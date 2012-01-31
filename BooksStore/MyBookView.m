//
//  MyBookView.m
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyBookView.h"
#import "ASIHTTPRequest.h"
#import "ZipArchive.h"
#import "MBProgressHUD.h"

@implementation MyBookView

@synthesize delegate;
@synthesize bookID;
@synthesize bookName;
@synthesize contentLength;
@synthesize bookPath;
@synthesize downButton;
//@synthesize pauseButton;
//@synthesize unZipButton;
@synthesize readButton;
//@synthesize deleteButton;
@synthesize zztjProView;
//@synthesize imageProView;
//@synthesize imageProBgView;
@synthesize downText;
@synthesize downloadCompleteStatus;
@synthesize zipCompleteStatus;

@synthesize iv,bgiv;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		self.backgroundColor = [UIColor grayColor];
		
        CGRect recta=CGRectMake(0.0, 0.0, MagazineViewWidth, MagazineViewHeight);
        
        self.iv=[[UIImageView alloc]initWithFrame:recta];
		self.bgiv=[[UIImageView alloc]initWithFrame:recta];
        
        self.iv.tag=7777;
        self.bgiv.tag=6666;
        
        //系统进度条的设置
		zztjProView = [[UIProgressView alloc] initWithFrame:CGRectMake(recta.origin.x, recta.origin.y+MagazineViewHeight-ProgressViewOriginYToCover, ProgressViewWidth, ProgressViewHeight)];
        
        //按钮
        
		//初始化阅读按键
         //self.downButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        self.readButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        readButton.frame =recta;
        [readButton addTarget:self action:@selector(readClick) forControlEvents:UIControlEventTouchUpInside];
		
        
        
        //初始化下载按键
		self.downButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		downButton.frame = CGRectMake(recta.origin.x+(MagazineViewWidth-ButtonWidth)/2, recta.origin.y+MagazineViewHeight+ButtonTOMagazine, ButtonWidth, ButtonHeight);
		[downButton setTitle:@"下载" forState:UIControlStateNormal];
		
		[downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
		
        //初始化显示书名的Lable
		downText = [[UILabel alloc] initWithFrame:CGRectMake(recta.origin.x, recta.origin.y+MagazineViewHeight+LabelTOMagazine, ProgressViewWidth, ProgressViewHeight)];
        downText.textAlignment = UITextAlignmentRight;
		[downText setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:bgiv];
        [self addSubview:iv];
        [self addSubview:zztjProView];
        [self addSubview:downText];
        [self addSubview:readButton];
		[self addSubview:downButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	//设置书的名字
	downText.text = bookName;
	//判断是否下载成功
	if (downloadCompleteStatus) {//下载状态(已经下载成功)
		if (zipCompleteStatus) {//已经解压成功
            [downButton setTitle:@"阅读" forState:UIControlStateNormal];
		    [downButton addTarget:self action:@selector(readClick) forControlEvents:UIControlEventTouchUpInside];
		    downButton.enabled = YES;
        }
        else
        {
            [downButton setTitle:@"请稍后。。" forState:UIControlStateNormal];
            [downButton addTarget:self action:@selector(readClick) forControlEvents:UIControlEventTouchUpInside];
            //downButton.enabled = NO;
            downText.text = @"安装中";
        }

		//系统进度条隐藏
		zztjProView.hidden = YES;

		
	}else {
		
		//下载按键显示
        [downButton setTitle:@"下载" forState:UIControlStateNormal];
		[downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
		downButton.enabled = YES;

	}
}

#pragma mark -
#pragma mark click method
- (void)downButtonClick {//下载按键事件
	
    //NSLog(@"aaaa");
	if ([delegate respondsToSelector:@selector(downBtnOfBookWasClicked:)]) {
		//下载按键禁用
		downButton.enabled = YES;
		//暂停按键启用
		//pauseButton.enabled = YES;
        [downButton setTitle:@"暂停" forState:UIControlStateNormal];
        [downButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
		//调用 DownAndASIRequestViewController 的 downBtnOfBookWasClicked 方法
		[delegate downBtnOfBookWasClicked:self];
	}
}

- (void)pauseButtonClick {//暂停按键事件
	
	if ([delegate respondsToSelector:@selector(pauseBtnOfBookWasClicked:)]) {
		//下载按键启用
        [downButton setTitle:@"下载" forState:UIControlStateNormal];
		[downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
		//调用 DownAndASIRequestViewController 的 pauseBtnOfBookWasClicked 方法
		[delegate pauseBtnOfBookWasClicked:self];
	}
	
}


-(void)readClick {//查看按键事件
	
	//if ([delegate respondsToSelector:@selector(readBtnOfBookWasClicked:)]) {
		
		//调用 DownAndASIRequestViewController 的 readBtnOfBookWasClicked 方法
		[delegate readBtnOfBookWasClicked:self];
	//}
}

- (void)deleteButtonClick {//删除按键事件
	//初始化Documents路径
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//设置ZIP文件路径
	NSString *zipPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",bookID]];
	//设置文件夹路径
	NSString *folderPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d",bookID]];
	//创建文件管理器
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//判断ZIP文件是否存在
	if ([fileManager fileExistsAtPath:zipPath]) {
		//如果存在就删除
		[fileManager removeItemAtPath:zipPath error:nil];
	}
	BOOL result;
	//判断文件夹是否存在
	if ([fileManager fileExistsAtPath:folderPath]) {
		//如果存在就删除
		result = [fileManager removeItemAtPath:folderPath error:nil];
	}
    else
    {
        result=NO;
    }
	//删除成功,所有按键回到最初状态
	if (result) {
		//系统进度条显示
		zztjProView.hidden = NO;
		//进度值为0
		zztjProView.progress = 0;
		//自己的进度条显示
		//imageProView.hidden = NO;
		//自己的进度条背景显示
		//imageProBgView.hidden = NO;
		//设置自己的进度条VIEW的frame的width为0
		//imageProView.frame = CGRectMake(75, 121, 0, 4);
		//下载状态为NO
		downloadCompleteStatus = NO;
        
        zipCompleteStatus = NO;
		//删除隐藏
		//deleteButton.hidden = YES;
		//查看隐藏
		//readButton.hidden = YES;
		//下载显示
		downButton.hidden = NO;
		//暂停显示
		//pauseButton.hidden = NO;
		//暂停禁用
		//pauseButton.enabled = NO;
		//把持久化的大小设置为0,当重新下载时重新赋值
		NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
		[userDefaults setObject:[NSNumber numberWithFloat:0.0] forKey:[NSString stringWithFormat:@"book_%d_contentLength",bookID]];
	}
}



#pragma mark -
#pragma mark ASIProgressDelegate method


- (void)setProgress:(float)newProgress {//进度条的代理
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
    //从持久化里面取出内容的总大小
	self.contentLength = [[userDefaults objectForKey:[NSString stringWithFormat:@"book_%d_contentLength",bookID]] floatValue];
	//NSLog(@"%.2f",self.contentLength*newProgress);
    
    //设置进度文本
	downText.text = [NSString stringWithFormat:@"%.2f/%.2fM",self.contentLength*newProgress,self.contentLength];
	
    //设置自己的进度条
	//imageProView.frame = CGRectMake(75, 121, 150*newProgress, 4);
    
	//设置系统的进度条
	zztjProView.progress = newProgress;
}



#pragma mark -
#pragma mark dealloc method

- (void)dealloc {
	
	/*[downButton release];
	//[pauseButton release];
    [bgiv release];
    [iv release];
	//[unZipButton release];
	//[readButton release];
	//[deleteButton release];
	[zztjProView release];
	//[imageProView release];
	//[imageProBgView release];
	[downText release];
	
    [super dealloc];*/
}


@end
