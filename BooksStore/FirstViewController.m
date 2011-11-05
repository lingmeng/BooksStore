//
//  FirstViewController.m
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize documentsBookPath,bundleBookPath,scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"书城", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)setHotFlag:(int)value atView:(UIView *)view withImagePath:(NSString *)hotImagePath{
    float x = (value%4)*(MagazineViewWidth+MagazineViewXGap)+MagazineViewToTopLeft+MagazineViewWidth-HotFlagWidth/2;//   40 第一个图片和最左边的距离
    
    float y = floor(value/4)*(MagazineViewHeight+MagazineViewYGap)+MagazineViewToTopTop-HotFlagHeight/2;
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(x, y, HotFlagWidth, HotFlagHeight)];
    [image setImage:[UIImage imageWithContentsOfFile:hotImagePath]];
    [view insertSubview:image aboveSubview:scrollView];
    
}

-(void)loadMagezines{
    
   NSString *fileDirectoryPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"testpath1"]; 
    
    NSArray* imageNames = [NSArray arrayWithObjects:
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"建筑师.png"], 
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"建筑实录.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"日本建筑.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"新建筑.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"世界建筑导报.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"建筑师.png"], 
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"建筑实录.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"日本建筑.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"新建筑.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"世界建筑导报.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"建筑师.png"], 
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"建筑实录.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"日本建筑.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"新建筑.png"],
                           [fileDirectoryPath 
                            stringByAppendingPathComponent:@"世界建筑导报.png"],
                          nil];
    int size=[imageNames count];
    NSString *hotImagePath=[fileDirectoryPath 
                           stringByAppendingPathComponent:@"热门期刊标记.png"];
    
    UIButton *Btn;
    UITextView *uiTextView;
    for (int i=0; i<size; i++) {
        
        CGRect frame;
        CGRect textFrame; 
        
        Btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        [Btn setImage:[UIImage imageWithContentsOfFile:[imageNames objectAtIndex: i]] forState:UIControlStateNormal];//设置按钮图片
        
        Btn.tag = i;
        
        frame.size.width = MagazineViewWidth;//设置按钮坐标及大小MagezineViewWidth 137
        
        frame.size.height = MagazineViewHeight;//MagezineViewHeight  183
        
        textFrame.size.width=TextWidth;
        textFrame.size.height=TextHeight;
        
       
        frame.origin.x = (i%4)*(MagazineViewWidth+MagazineViewXGap)
        +MagazineViewToTopLeft;
        
        frame.origin.y = floor(i/4)*(MagazineViewHeight+MagazineViewYGap)
        +MagazineViewToTopTop;
        
        textFrame.origin.x =frame.origin.x;
        
        textFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap;
        
        
        [Btn setFrame:frame];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
       
        [scrollView addSubview:Btn];
        //if (i==7) {
           
       // }
        [Btn release];
       uiTextView=[[UITextView alloc]initWithFrame:textFrame];
        [uiTextView insertText:@"世界导报 1期"];
        uiTextView.editable=false;
          [scrollView addSubview:uiTextView];
        
    }
    [self setHotFlag:7 atView:scrollView withImagePath:hotImagePath];
    [self setHotFlag:9 atView:scrollView withImagePath:hotImagePath];
    [self setHotFlag:12 atView:scrollView withImagePath:hotImagePath];
    
    int mainfloor=size/4;
    int ifaddone=size%4==0?0:1;
    int height=(mainfloor+ifaddone)*(MagazineViewHeight+MagazineViewYGap)+MagazineViewYGap;
    [scrollView setContentSize:CGSizeMake(844, height)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
}
-(IBAction)clickcategorys:(id)sender{

}

-(void)btnPressed:(id)sender{
    
    UIButton *Btn = (UIButton *)sender;
    
    int index = Btn.tag;
    
    switch (index) {
            
        case 0:
            
            break;
            
            //其他几个控制器类似
            
    }
    
}
#pragma mark - View lifecycle
-(void)writeToFileWithMagazineId:(NSString *)magazineid{
    //对于错误信息
    NSError *error;
    // 创建文件管理器
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSString *fileDirectoryPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"testpath1"];
    [[NSFileManager defaultManager]   createDirectoryAtPath:fileDirectoryPath  withIntermediateDirectories:YES attributes:nil error:&error ];
    
    
    NSString *filePath= [fileDirectoryPath 
                         stringByAppendingPathComponent:@"file3.txt"];
    //需要写入的字符串
    NSString *str= @"iPhoneDeveloper Tips\nhttp://iPhoneDevelopTips,com";
    //写入文件
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    //显示文件目录的内容
    NSLog(@"Documentsdirectory: %@",[fileMgr contentsOfDirectoryAtPath:filePath error:&error]);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadMagezines];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self startme:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
//bool ishidden=YES;
-(IBAction)startme:(id)sender{
    [self hideBar];
    /* // Determine the Class for the parser
     Class parserClass = nil;
     parserClass = [LibXMLParser class];
     // Create the parser, set its delegate, and start it.
     self.parser = [[[parserClass alloc] init] autorelease];      
     parser.delegate = self;
     [parser start];
     
     
     
     NSString* path = [[NSBundlemainBundle]   pathForResource:@"Test" ofType:@"xml"];
     NSFileHandle* file = [NSFileHandlefileHandleForReadingAtPath:path];
     NSData* data = [file readDataToEndOfFile];
     */
    //构造登录请求url  
    /*
     NSString* url=[NSString stringWithFormat:@"file:///%@/%@",[[NSBundle mainBundle] bundlePath],@"Test.xml"];  
     
     NSOperationQueue *_queue = [[NSOperationQueue alloc] init];  
     URLOperation* operation=[[URLOperation alloc ]initWithURLString:url];  
     
     //kvo注册  
     [operation addObserver:self forKeyPath:@"isFinished"  
     options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:operation];  
     
     
     // 开始处理  
     [_queue addOperation:operation];  
     [operation release];//队列已对其retain，可以进行release；
     */
}


//接收变更通知  并实现 observeValueForKeyPath 方法：
- (void)observeValueForKeyPath:(NSString *)keyPath  
                      ofObject:(id)object  
                        change:(NSDictionary *)change  
                       context:(void *)context  
{  
    /* if ([keyPath isEqual:@"isFinished"]) {  
     BOOL isFinished=[[change objectForKey:NSKeyValueChangeNewKey] intValue];  
     if (isFinished) {//如果服务器数据接收完毕  
     //[indicatorView stopAnimating];  
     URLOperation* ctx=(URLOperation*)context;  
     NSStringEncoding enc=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);  
     NSLog(@"%@",[[NSString alloc] initWithData:[ctx data] encoding:enc]);  
     //取消kvo注册  
     [ctx removeObserver:self  
     forKeyPath:@"isFinished"];  
     }        
     }else{  
     // be sure to call the super implementation  
     // if the superclass implements it  
     [super observeValueForKeyPath:keyPath  
     ofObject:object  
     change:change  
     context:context];  
     }  */
} 


@end
