//
//  SecondViewController.m
//  BooksStore
//
//  Created by meng ling on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
@synthesize bScrollView;
NSMutableArray *results;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"我的书架", @"我的书架");
        self.tabBarItem.image = [UIImage imageNamed:@"我的书架"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark -download magezine
- (Boolean)downBtnOfBookWasClicked:(MyBookView *)book{
    //http://www.sss.com/downloadbooks/bookid/book.xml
    //NSLog(@"downBtnOfBookWasClicked %d",book.bookID);
    int bookid=book.bookID;
    //先下载图书
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
	book.bookPath=[NSString stringWithFormat:@"%@/Book%d/Book%d.zip",DownloadROOTURL,bookid,bookid];
    
    NSLog(@"book id:%d",book.bookID);
    
   
    //设置下载路径
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:book.bookPath]];
	//设置ASIHTTPRequest代理
	request.delegate = self;
    
    [request setAllowResumeForFileDownloads:YES];
    
    //初始化临时文件路径
	NSString *folderPath = [path stringByAppendingPathComponent:@"temp"];
	//创建文件管理器
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
    BOOL fileExists = [fileManager fileExistsAtPath:folderPath];
	
	if (!fileExists) {//如果不存在说创建,因为下载时,不会自动创建文件夹
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
    //初始化保存ZIP文件路径
	NSString *savePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Book%d.zip",bookid]];
    //初始化临时文件路径(必须设置否则不支持续传)
	NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"temp/Book%d.zip.temp",book.bookID]];
	
    [request setTemporaryFileDownloadPath:tempPath];
    [request setDownloadDestinationPath:savePath];
    //设置请求中的数据书的编号
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:book.bookID],@"bookID",nil]];
    //设置进度条的代理,
	[request setDownloadProgressDelegate:book];
	//初始化临时文件路径
  
    [netWorkQueue addOperation:request];
    [request release];
    //[request startAsynchronous];
    //然后维护关系
    return CommandOk;
    
    
   
    
}
/*
- (void)pauseBtnOfBookWasClicked:(MyBookView *)book {//暂停下载
	
	//for (ASIHTTPRequest *request in [netWorkQueue operations]) {//查找暂停的对象
    
    NSInteger bookid = [[request.userInfo objectForKey:@"bookID"] intValue];//查看userinfo信息
    if (book.bookID == bookid) {//判断ID是否匹配
        //暂停匹配对象
        [request clearDelegatesAndCancel];
    }
	//}
}*/
//ASIHTTPRequestDelegate,下载之前获取信息的方法,主要获取下载内容的大小
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
    
	//NSLog(@"didReceiveResponseHeaders-%@",[responseHeaders valueForKey:@"Content-Length"]);
    for (int k=0; k<[[self.view subviews]count]; k++) {
        UIView *sbv=[[self.view subviews]objectAtIndex:k];
        for (int m=0; m<[[sbv subviews]count]; m++) {
            UIView *sbv1=[[sbv subviews]objectAtIndex:m];
            
            if (sbv1.tag==99999) {
                
                for (MyBookView *temp in [sbv1 subviews]) {//循环出具体对象
                    
                    
                    if ([temp respondsToSelector:@selector(bookID)]) {
                        //    NSLog(@"bid %d,length %f,requesturl %@ ",temp.bookID,request.contentLength/1024.0/1024.0,[[request url]path]);
                        if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {
                            //查找以前是否保存过 具体对象 内容的大小
                            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                            float tempConLen = [[userDefaults objectForKey:[NSString stringWithFormat:@"book_%d_contentLength",temp.bookID]] floatValue];
                           
                            //NSLog(@"tempConLen %f",tempConLen);
                            
                            if (tempConLen == 0 ) {//如果没有保存,则持久化他的内容大小
                                
                                [userDefaults setObject:[NSNumber numberWithFloat:request.contentLength/1024.0/1024.0] forKey:[NSString stringWithFormat:@"book_%d_contentLength",temp.bookID]];
                                
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
}

- (void)pauseBtnOfBookWasClicked:(MyBookView *)book {//暂停下载
	
	for (ASIHTTPRequest *request in [netWorkQueue operations]) {//查找暂停的对象
		
		NSInteger bookid = [[request.userInfo objectForKey:@"bookID"] intValue];//查看userinfo信息
		if (book.bookID == bookid) {//判断ID是否匹配
			//暂停匹配对象
			[request clearDelegatesAndCancel];
		}
	}
}


- (void)readBtnOfBookWasClicked:(MyBookView *)book {
	//book.bookID
    ReadController *rd=(ReadController *)[self.tabBarController.viewControllers objectAtIndex:2];
    NSLog(@"--%d",book.bookID);
    rd.choosedMagazineId=book.bookID;
    //转到第三页面，阅读
    self.tabBarController.selectedIndex=2;
    
}

- (void)deleteBtnOfBookWasClicked:(MyBookView *)book{
   //删除文件夹
    //修改已购买杂志存在状态no 设置bookView的解压状态为no 重绘book
}
//ASIHTTPRequestDelegate,下载完成时,执行的方法
- (void)requestFinished:(ASIHTTPRequest *)request {
    for (int k=0; k<[[self.view subviews]count]; k++) {
        UIView *sbv=[[self.view subviews]objectAtIndex:k];
        for (int m=0; m<[[sbv subviews]count]; m++) {
            UIView *sbv1=[[sbv subviews]objectAtIndex:m];
            
            if (sbv1.tag=99999) {
                
                for (MyBookView *temp in [sbv1 subviews]) {//循环出具体对象
                    
                    
                    if ([temp respondsToSelector:@selector(bookID)]) {
                        //    NSLog(@"bid %d,length %f,requesturl %@ ",temp.bookID,request.contentLength/1024.0/1024.0,[[request url]path]);
                        if (temp.bookID == [[request.userInfo objectForKey:@"bookID"] intValue]) {
                            temp.downloadCompleteStatus = YES;//如果匹配,则设置他的下载状态为YES
                            temp.zipCompleteStatus=NO;
                            //重绘
                            [temp setNeedsDisplay];
                            NSString *path =  [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
                            NSString *originFile=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"Book%d.zip",temp.bookID]];
                            NSString *destFile=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"BookContent",temp.bookID]];
                            [self unZipFromfilepath:originFile 
                                         tofilepath:destFile];
                            temp.zipCompleteStatus=YES;
                            
                            //更改存在标志
                            for (int i=0; i<[results count]; i++) {
                                PaidMagazineListPreView *pv=  (PaidMagazineListPreView *)[results objectAtIndex:i];
                                if (pv.MagazineId.intValue==temp.bookID) {
                                    //1保存已购图书的状态
                                    pv.isExsisit=[NSNumber numberWithInt:1]; 
                                    //2解析图书xml并保存
                                    [self saveMagezineXmlWithBookId:temp.bookID];
                                    
                                    
                                   
                                    
                                    
                                }
                            }
                           [temp setNeedsDisplay];
                             
                           //@"张三";
                            
                            
                        }
                    }
                }
                
            }
        }
    }
}
//ASIHTTPRequestDelegate,下载失败
- (void)requestFailed:(ASIHTTPRequest *)request {
    
	NSLog(@"down fail.....");
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(300, 220, 200, 100)];
	label.text = @"down fail,请检查网络是否连接!";
	[self.view addSubview:label];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
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
    netWorkQueue  = [[ASINetworkQueue alloc] init];
    [netWorkQueue reset];
    [netWorkQueue setShowAccurateProgress:YES];
    [netWorkQueue go];
    //NSLog(@"view will appear!!");
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    }
   
    results=[self retrieveDataWithEntityName:@"PaidMagazineListPreView" fetchLimit:-1 predicate:nil orderField:@"MagazineId" isAscending:YES inManagedObjectContext:self.managedObjectContext];
   
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/books/"];
    for (int i=0;i<[results count];i++)
    { 
        NSLog(@"---size %d",[results count]);
        PaidMagazineListPreView *pdmgl=[results objectAtIndex:i];
        CGRect frame;
        frame.size.width = MagazineViewWidth;//设置按钮坐标及大小MagezineViewWidth 137
        
        frame.size.height = MagazineViewHeight+80;//MagezineViewHeight  183
        
        
        frame.origin.x = (i%4)*(MagazineViewWidth+MagazineViewXGap)+MagazineViewToTopLeft;
        
        frame.origin.y = floor(i/4)*(MagazineViewHeight+MagazineViewYGap)+MagazineViewToTopTop;
        NSString *bgimageName = [NSString stringWithFormat:@"杂志缓冲背景.png"];
        
        MyBookView *myBook = [[MyBookView alloc] initWithFrame:frame];
        myBook.bookID=pdmgl.MagazineId.intValue;
       
        NSLog(@"bookID %d",myBook.bookID);
        
        myBook.tag=100000+i;
        
        [myBook.iv setImage:[UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:pdmgl.MagazineCover]]];
        [myBook.bgiv setImage:[UIImage imageNamed:bgimageName]];
        [myBook.readButton setBackgroundImage:[UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:pdmgl.MagazineCover]] forState:UIControlStateNormal];
        
        myBook.userInteractionEnabled=YES;
        bScrollView.tag=99999;
        myBook.delegate=self;
        
        NSLog(@"pdmgl.isExsisit.intValue %d",pdmgl.isExsisit.intValue);
       
       
        
        [bScrollView addSubview:myBook];
        //判断是否存在
        if (pdmgl.isExsisit.intValue==1) {
            myBook.downloadCompleteStatus=YES;
            myBook.zipCompleteStatus=YES;
        }
        else
        {
            myBook.downloadCompleteStatus=NO;
            myBook.zipCompleteStatus=NO;
        }
        [myBook setNeedsDisplay];
    }
       
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return YES;
//}
- (void)dealloc {
	
	[netWorkQueue reset];
    [super dealloc];
}

@end
