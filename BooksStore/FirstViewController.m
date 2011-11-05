//
//  FirstViewController.m
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize documentsBookPath,bundleBookPath;
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

-(void)loadMagezines{
    NSArray* imageNames = [NSArray arrayWithObjects:
                           
                           @"ico_mobile.png",
                           
                           @"ico_idcard.png",
                           
                           @"ico_postcode.png",
                           
                           @"ico_flight.png",
                           
                           @"ico_translate.png",
                           
                           @"ico_phone.png",
                           
                           @"ico_car.png",
                           
                           @"ico_health.png",
                           
                           @"ico_bjxm.png", nil];
    
    UIButton *Btn;
    
    for (int i=0; i<9; i++) {
        
        CGRect frame;
        
        Btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        [Btn setImage:[UIImage imageNamed:[imageNames objectAtIndex: i]] forState:UIControlStateNormal];//设置按钮图片
        
        Btn.tag = i;
        
        frame.size.width = 59;//设置按钮坐标及大小MagezineViewWidth
        
        frame.size.height = 75;//MagezineViewHeight
        
        frame.origin.x = (i%4)*(59+32)+40;//32左右艰巨  24 上下艰巨   40 第一个图片和最左边的距离 以及和最上面的距离
        
        frame.origin.y = floor(i/4)*(75+24)+40;
        
        [Btn setFrame:frame];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:Btn];
        
        [Btn release];
        
    }
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

- (void)viewDidLoad
{
    [super viewDidLoad];
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
