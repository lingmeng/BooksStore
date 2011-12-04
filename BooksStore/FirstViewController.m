//
//  FirstViewController.m
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize documentsBookPath,bundleBookPath,scrollView,nextsv,nextbv,signesv,signeView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"书城", @"建筑书城");
        self.tabBarItem.image = [UIImage imageNamed:@"建筑书城"];
       

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
    [image release];
    
}
//报文存储
-(void)sychronizeMagazine{
   
}

-(void)loadMagezines{
    
//   NSString *fileDirectoryPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"testpath1"]; 
    
//    NSArray* imageNames = [NSArray arrayWithObjects:
//                           [fileDirectoryPath 
//                            stringByAppendingPathComponent:@"建筑师.png"], 
//                           [fileDirectoryPath 
//                            stringByAppendingPathComponent:@"建筑实录.png"],
//                           [fileDirectoryPath 
//                            stringByAppendingPathComponent:@"日本建筑.png"],
//                           [fileDirectoryPath 
//                            stringByAppendingPathComponent:@"新建筑.png"],
//                           [fileDirectoryPath 
//                            stringByAppendingPathComponent:@"世界建筑导报.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"建筑师.png"], 
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"建筑实录.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"日本建筑.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"新建筑.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"世界建筑导报.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"建筑师.png"], 
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"建筑实录.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"日本建筑.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"新建筑.png"],
////                           [fileDirectoryPath 
////                            stringByAppendingPathComponent:@"世界建筑导报.png"],
//                          nil];
    //int size=[imageNames count];
    NSArray* imageNames = [NSArray arrayWithObjects:@"世界建筑导报",@"建筑实录",@"建筑师",@"建筑结构",@"新建筑",@"日本建筑",@"LP地标",@"世界建筑导报",@"建筑实录",@"建筑师",@"建筑结构",@"新建筑",@"日本建筑", nil];
    int size = [imageNames count];//7;
//    NSString *hotImagePath=[fileDirectoryPath 
//                           stringByAppendingPathComponent:@"hot.png"];
    NSString *hotImagePath = [[NSBundle mainBundle] pathForResource:@"hot" ofType:@"png"];
   // [NSString stringWithFormat:@"hot.png"];
    UIButton *Btn;
    UILabel *uiTextView;
    UIImageView *bookshadow;
    UIImageView *bookLine;
    
    for (int i=0; i<size; i++) {
        
        CGRect frame;
        CGRect textFrame; 
        CGRect bookshadowFrame;
        CGRect bookLineFrame;
        Btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
       // [Btn setImage:[UIImage imageWithContentsOfFile:[imageNames objectAtIndex: i]] forState:UIControlStateNormal];//设置按钮图片
       
        NSString *imageName = [NSString stringWithFormat:@"x%d.png",i+1];
        NSString *bgimageName = [NSString stringWithFormat:@"杂志缓冲背景.png"];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *bgimage = [UIImage imageNamed:bgimageName];
        [Btn setBackgroundImage:bgimage forState:UIControlStateNormal];
        [Btn setImage:image forState:UIControlStateNormal];
        
        
        Btn.tag = i;
        
        frame.size.width = MagazineViewWidth;//设置按钮坐标及大小MagezineViewWidth 137
        
        frame.size.height = MagazineViewHeight;//MagezineViewHeight  183
        
        textFrame.size.width=TextWidth;
        textFrame.size.height=TextHeight;
        
        bookshadowFrame.size.width = bookshadowWidth;
        bookshadowFrame.size.height = bookshadowHeight;
        
        bookLineFrame.size.width = bookLineWidth;
        bookLineFrame.size.height = bookLineHeight;
    
       
        frame.origin.x = (i%4)*(MagazineViewWidth+MagazineViewXGap)
        +MagazineViewToTopLeft;
        
        frame.origin.y = floor(i/4)*(MagazineViewHeight+MagazineViewYGap)
        +MagazineViewToTopTop;
        
        textFrame.origin.x =frame.origin.x;
        
        textFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap+5;
        
        bookshadowFrame.origin.x = frame.origin.x;
        bookshadowFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap-2;
        
        bookLineFrame.origin.x = 28;
        bookLineFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap+MagazineViewYGap/2;
        
        [Btn setFrame:frame];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
       
        [scrollView addSubview:Btn];
        //if (i==7) {
           
       // }
        [Btn release];
        
        
        
       uiTextView=[[UILabel alloc]initWithFrame:textFrame];
        uiTextView.backgroundColor = [UIColor clearColor];
        
        [uiTextView setText:[imageNames objectAtIndex: i]];
        uiTextView.textColor = [UIColor colorWithRed:193/255.0f green:193/255.0f blue:193/255.0f alpha:1];
        uiTextView.textAlignment = UITextAlignmentLeft;
        uiTextView.font = [UIFont systemFontOfSize:14];
          [scrollView addSubview:uiTextView];
        [uiTextView release];
        
        bookshadow = [[UIImageView alloc] initWithFrame:bookshadowFrame];
        bookshadow.image = [UIImage imageNamed:@"建筑书刊阴影_137x34.png"];
        [scrollView addSubview:bookshadow];
        [bookshadow release];
        
        bookLine = [[UIImageView alloc] initWithFrame:bookLineFrame];
        bookLine.image = [UIImage imageNamed:@"图书横向分隔条.png"];
        //bookLine.alpha = 0.6f;
        [scrollView addSubview:bookLine];
        [bookLine release];
    }
    [self setHotFlag:0 atView:scrollView withImagePath:hotImagePath];
//    [self setHotFlag:0 atView:scrollView withImagePath:hotImagePath];
//    [self setHotFlag:9 atView:scrollView withImagePath:hotImagePath];
//    [self setHotFlag:12 atView:scrollView withImagePath:hotImagePath];
    
    int mainfloor=size/4;
    int ifaddone=size%4==0?0:1;
    int height=(mainfloor+ifaddone)*(MagazineViewHeight+MagazineViewYGap)+MagazineViewYGap;
    [scrollView setContentSize:CGSizeMake(780, height)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
}
-(void)loadMagezinesNumber{
    
    //   NSString *fileDirectoryPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"testpath1"]; 
    
    //    NSArray* imageNames = [NSArray arrayWithObjects:
    //                           [fileDirectoryPath 
    //                            stringByAppendingPathComponent:@"建筑师.png"], 
    //                           [fileDirectoryPath 
    //                            stringByAppendingPathComponent:@"建筑实录.png"],
    //                           [fileDirectoryPath 
    //                            stringByAppendingPathComponent:@"日本建筑.png"],
    //                           [fileDirectoryPath 
    //                            stringByAppendingPathComponent:@"新建筑.png"],
    //                           [fileDirectoryPath 
    //                            stringByAppendingPathComponent:@"世界建筑导报.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"建筑师.png"], 
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"建筑实录.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"日本建筑.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"新建筑.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"世界建筑导报.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"建筑师.png"], 
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"建筑实录.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"日本建筑.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"新建筑.png"],
    ////                           [fileDirectoryPath 
    ////                            stringByAppendingPathComponent:@"世界建筑导报.png"],
    //                          nil];
    //int size=[imageNames count];
    NSArray* imageNames = [NSArray arrayWithObjects:@"世界建筑导报第一期",@"世界建筑导报第二期",@"世界建筑导报第三期",@"世界建筑导报第四期",@"世界建筑导报第五期",@"世界建筑导报第六期",@"世界建筑导报第七期",@"世界建筑导报第八期",@"世界建筑导报第九期",@"世界建筑导报第十期",@"世界建筑导报第十一期",@"世界建筑导报第十二期" ,nil];
    int size = [imageNames count];//7;
    //    NSString *hotImagePath=[fileDirectoryPath 
    //                           stringByAppendingPathComponent:@"hot.png"];
  //  NSString *hotImagePath = [[NSBundle mainBundle] pathForResource:@"hot" ofType:@"png"];
    // [NSString stringWithFormat:@"hot.png"];
    UIButton *Btn;
    UILabel *uiTextView;
    UIImageView *bookshadow;
    UIImageView *bookLine;
    
    for (int i=0; i<size; i++) {
        
        CGRect frame;
        CGRect textFrame; 
        CGRect bookshadowFrame;
        CGRect bookLineFrame;
        Btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        // [Btn setImage:[UIImage imageWithContentsOfFile:[imageNames objectAtIndex: i]] forState:UIControlStateNormal];//设置按钮图片
        
        NSString *imageName = [NSString stringWithFormat:@"x1.png"];
        UIImage *image = [UIImage imageNamed:imageName];
        if (i!=11) {
            [Btn setImage:image forState:UIControlStateNormal];
        }else
        {
            [Btn setImage:nil forState:UIControlStateNormal];
        }
        
        NSString *bgimageName = [NSString stringWithFormat:@"杂志缓冲背景.png"];
        UIImage *bgimage = [UIImage imageNamed:bgimageName];
        [Btn setBackgroundImage:bgimage forState:UIControlStateNormal];
        Btn.tag = i;
        
        frame.size.width = MagazineViewWidth;//设置按钮坐标及大小MagezineViewWidth 137
        
        frame.size.height = MagazineViewHeight;//MagezineViewHeight  183
        
        textFrame.size.width=TextWidth;
        textFrame.size.height=TextHeight;
        
        bookshadowFrame.size.width = bookshadowWidth;
        bookshadowFrame.size.height = bookshadowHeight;
        
        bookLineFrame.size.width = bookLineWidth;
        bookLineFrame.size.height = bookLineHeight;
        
        
        frame.origin.x = (i%4)*(MagazineViewWidth+MagazineViewXGap)
        +MagazineViewToTopLeft;
        
        frame.origin.y = floor(i/4)*(MagazineViewHeight+MagazineViewYGap)
        +MagazineViewToTopTop;
        
        textFrame.origin.x =frame.origin.x;
        
        textFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap+5;
        
        bookshadowFrame.origin.x = frame.origin.x;
        bookshadowFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap-2;
        
        bookLineFrame.origin.x = 28;
        bookLineFrame.origin.y = frame.origin.y+MagazineViewHeight+TextToMagazineGap+MagazineViewYGap/2;
        
        [Btn setFrame:frame];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        
        [Btn addTarget:self action:@selector(MagezinesPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [nextsv addSubview:Btn];
        //if (i==7) {
        
        // }
        [Btn release];
        
        
        
        uiTextView=[[UILabel alloc]initWithFrame:textFrame];
        uiTextView.backgroundColor = [UIColor clearColor];
        
        [uiTextView setText:[imageNames objectAtIndex: i]];
        uiTextView.textColor = [UIColor colorWithRed:193/255.0f green:193/255.0f blue:193/255.0f alpha:1];
        uiTextView.textAlignment = UITextAlignmentLeft;
        uiTextView.font = [UIFont systemFontOfSize:14];
        [nextsv addSubview:uiTextView];
        [uiTextView release];
        
        bookshadow = [[UIImageView alloc] initWithFrame:bookshadowFrame];
        bookshadow.image = [UIImage imageNamed:@"建筑书刊阴影_137x34.png"];
        [nextsv addSubview:bookshadow];
        [bookshadow release];
        
        bookLine = [[UIImageView alloc] initWithFrame:bookLineFrame];
        bookLine.image = [UIImage imageNamed:@"图书横向分隔条.png"];
        //bookLine.alpha = 0.6f;
        [nextsv addSubview:bookLine];
        [bookLine release];
    }
   // [self setHotFlag:3 atView:nextsv withImagePath:hotImagePath];
    //    [self setHotFlag:0 atView:scrollView withImagePath:hotImagePath];
    //    [self setHotFlag:9 atView:scrollView withImagePath:hotImagePath];
    //    [self setHotFlag:12 atView:scrollView withImagePath:hotImagePath];
    
    int mainfloor=size/4;
    int ifaddone=size%4==0?0:1;
    int height=(mainfloor+ifaddone)*(MagazineViewHeight+MagazineViewYGap)+MagazineViewYGap;
    [nextsv setContentSize:CGSizeMake(780, height)];
    [nextsv setBackgroundColor:[UIColor clearColor]];
}


-(void)loadSingeMagezines{
    
    
    UIImageView *bookTitleshadow;
    NSArray* imageNames = [NSArray arrayWithObjects:@"世界建筑导报第一期",@"世界建筑导报第二期",@"世界建筑导报第三期",@"世界建筑导报第四期",@"世界建筑导报第五期",@"世界建筑导报第六期",@"世界建筑导报第七期",@"世界建筑导报第八期",@"世界建筑导报第九期",@"世界建筑导报第十期",@"世界建筑导报第十一期", nil];
    int size = [imageNames count];
    
    for (int i=0; i<size; i++) {
        
       
        CGRect bookTitleshadowhadowFrame;
        
        
        bookTitleshadowhadowFrame.size.width = bookTitleshadowWidth;
        bookTitleshadowhadowFrame.size.height = bookTitleshadowHeight;
        
        
        
        bookTitleshadowhadowFrame.origin.x = (i%2)*(bookTitleshadowWidth+bookTitleMagazineViewXGap)
        +bookTitleMagazineViewToTopLeft;
        
        bookTitleshadowhadowFrame.origin.y = floor(i/2)*(bookTitleshadowHeight+bookTitleMagazineViewYGap)
        +bookTitleMagazineViewToTopTop;
        
        bookTitleshadow = [[UIImageView alloc] initWithFrame:bookTitleshadowhadowFrame];
        bookTitleshadow.image = [UIImage imageNamed:@"tu1.png"];
        bookTitleshadow.userInteractionEnabled = YES;
        [signesv addSubview:bookTitleshadow];
        [bookTitleshadow release];
        
    }
    int mainfloor=size/2;
    int ifaddone=size%2==0?0:1;
    int height=(mainfloor+ifaddone)*(bookTitleshadowHeight+bookTitleMagazineViewYGap)+bookTitleMagazineViewToTopTop;
    [signesv setContentSize:CGSizeMake(512, height)];
    [signesv setBackgroundColor:[UIColor clearColor]];
}

-(IBAction)clickcategorys:(id)sender{

}
-(IBAction)Magezines:(id)sender
{
    scrollView.hidden = NO;
    nextsv.hidden = YES;
    nextsv = nil;
    //[self loadMagezines];
}

-(void)btnPressed:(id)sender{
    
    UIButton *Btn = (UIButton *)sender;
    
    int index = Btn.tag;
    
    switch (index) {
            
        case 0:
            nextsv.hidden = NO;
            scrollView.hidden = YES;
            nextsv = [[UIScrollView alloc] init];
            nextsv.frame = CGRectMake(36, 116, 780, 630);
            [self.view addSubview:nextsv];
            [self loadMagezinesNumber];
           
            [nextsv release];

            break;
            
            //其他几个控制器类似
            
    }
    
}

int singeView_hidden = 0;

-(void)MagezinesPressed:(id)sender{
    
    UIButton *Btn = (UIButton *)sender;
    
    int index = Btn.tag;
    
    switch (index) {
            
        case 0:

            if (singeView_hidden ) {
                singeView_hidden = 0;
                signeView.center = CGPointMake(1341, 374);
               // signesv = [[UIScrollView alloc] init];
                signesv.frame = CGRectMake(122, 269, 780, 630);
                [self.view addSubview:signeView];
                [signeView addSubview:signesv];
                CATransition *animation = [CATransition animation];
                [animation setDuration:0.25f];
                [animation setTimingFunction:[CAMediaTimingFunction
                                              functionWithName:kCAMediaTimingFunctionDefault]];
                [animation setType:kCATransitionPush];
                [animation setSubtype:kCATransitionFromLeft];
                [signeView.layer addAnimation:animation forKey:@"Push"];
                
               // signeView = nil;
                [signesv removeFromSuperview];
                signesv = nil;
                
            }else
            {
                singeView_hidden = 1;
            
            signeView.center = CGPointMake(707, 374);
            signesv = [[UIScrollView alloc] init];
            signesv.frame = CGRectMake(122, 269, 780, 630);
            [self.view addSubview:signeView];
            [signeView addSubview:signesv];
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.25f];
            [animation setTimingFunction:[CAMediaTimingFunction
                                          functionWithName:kCAMediaTimingFunctionDefault]];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [signeView.layer addAnimation:animation forKey:@"Push"];
            [self loadSingeMagezines];
            
            [signesv release];
            }
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
//    NSLog(@"Documentsdirectory: %@",[fileMgr contentsOfDirectoryAtPath:filePath error:&error]);
    
}

-(void)silderButton{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int flag=[self needSychronize];
    if (flag==1) {
        [self sychronizeWithServ:1];
    }else if (flag==2) {
         [self sychronizeWithServ:2];
    }else if (flag==3) {
         [self sychronizeWithServ:3];
    }
    
    [self loadMagezines];
    //nextsv.hidden = YES;
    //[self hideBar];

      
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"view will app");
//    for(UIView *view in self.tabBarController.view.subviews)
//    {
//        if ([view isKindOfClass:[UITabBar class]]) {
//            [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
//            NSLog(@"qqqqqqqqqsssss%f",view.frame.origin.y);
//        }
//    }
//    [super viewWillAppear:animated];
    
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

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return YES;
//}
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
