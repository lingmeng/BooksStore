//
//  FirstViewController.m
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize documentsBookPath,bundleBookPath,scrollView,nextsv,nextbv,signesv,signeView,priceLabel,description,paybutton,cover,groupLabel;
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
   // [image release];
    
}
//报文存储
-(void)sychronizeMagazine{
   
}
//1:载入类别
-(Boolean)loadMagezines{
    
   // NSError *error;
   // NSFetchRequest *request=[[NSFetchRequest alloc] init]; 
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext: %@",  self.managedObjectContext);
    }
  
    NSMutableArray *results=[self retrieveDataWithEntityName:@"MagazineListPreView" fetchLimit:1000 predicate:nil orderField:@"MagazineId" isAscending:YES inManagedObjectContext:self.managedObjectContext];
    int size = [results count];
    /* 
     NSEntityDescription *entity=[NSEntityDescription entityForName:@"MagazineListPreView" inManagedObjectContext:[self managedObjectContext]]; 
    [request setEntity:entity];
    
    NSArray *results=[[[self managedObjectContext] executeFetchRequest:request error:&error] copy];
    int size = [results count];
    
    NSLog(@"size %d",size);
    */
    UIButton *Btn;
    UILabel *uiTextView;
    UIImageView *bookshadow;
    UIImageView *bookLine;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/books/"];
    if ([results count]>0) {
            
    for (int i=0;i<[results count];i++) { 
        // MagazineGroup *group in results
        MagazineListPreView *books=(MagazineListPreView *)[results objectAtIndex:i];
        CGRect frame;
        CGRect textFrame; 
        CGRect bookshadowFrame;
        CGRect bookLineFrame;
        
        Btn = [UIButton buttonWithType:UIButtonTypeCustom];// retain];
        
        NSString *imageName =books.MagazineCover;        // [NSString stringWithFormat:@"x%d.png",i+1];
        NSString *bgimageName = [NSString stringWithFormat:@"杂志缓冲背景.png"];
        UIImage *image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:imageName]];
        UIImage *bgimage = [UIImage imageNamed:bgimageName];
        
        [Btn setBackgroundImage:bgimage forState:UIControlStateNormal];
        [Btn setImage:image forState:UIControlStateNormal];
        
    
        
        Btn.tag = books.MagazineId.intValue;
        
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
        
        //[Btn release];
        
        uiTextView=[[UILabel alloc]initWithFrame:textFrame];
        uiTextView.backgroundColor = [UIColor clearColor];
        
        [uiTextView setText:[NSString stringWithFormat:@"第%d期",books.Period.intValue]];//[imageNames objectAtIndex: i]];
        uiTextView.textColor = [UIColor colorWithRed:193/255.0f green:193/255.0f blue:193/255.0f alpha:1];
        uiTextView.textAlignment = UITextAlignmentCenter;
        uiTextView.font = [UIFont systemFontOfSize:14];
        [scrollView addSubview:uiTextView];
       // [uiTextView release];
        
        
        bookshadow = [[UIImageView alloc] initWithFrame:bookshadowFrame];
        bookshadow.image = [UIImage imageNamed:@"建筑书刊阴影_137x34.png"];
        [scrollView addSubview:bookshadow];
        //[bookshadow release];
        
        bookLine = [[UIImageView alloc] initWithFrame:bookLineFrame];
        bookLine.image = [UIImage imageNamed:@"图书横向分隔条.png"];
        //bookLine.alpha = 0.6f;
        [scrollView addSubview:bookLine];
        //[bookLine release];
         
        
        CGRect btnFrame=CGRectMake(frame.origin.x,frame.origin.y+MagazineViewHeight+TextToMagazineGap+5+TextHeight+15, BtnToTextWidth, BtnToTextHeight);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];// retain];
        [button setTitle:@"购买" forState:UIControlStateNormal]; 
        [button setFrame:btnFrame];
        button.tag=books.MagazineId.intValue;
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(buypressed:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
       // [button release];
    }
        NSString *hotImagePath = [[NSBundle mainBundle] pathForResource:@"hot" ofType:@"png"];
        
        [self setHotFlag:0 atView:scrollView withImagePath:hotImagePath];
    }
    else
    {
        
    }
       
    int mainfloor=size/4;
    int ifaddone=size%4==0?0:1;
    int height=(mainfloor+ifaddone)*(MagazineViewHeight+MagazineViewYGap)+MagazineViewYGap;
    
    [scrollView setContentSize:CGSizeMake(780, height)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    return TRUE;
}
-(void)buypressed:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
   
    SecondViewController *se=(SecondViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
    
    se.choosedMagazineId= btn.tag;
    //点击购买购买成功，记录已购买标志到中间表
    if([self buyMagazineById:btn.tag])
    {
        //转到第二页面，显示下载按钮
        self.tabBarController.selectedIndex=1;
    }; 
}

//2：点击类别
-(void)btnPressed:(id)sender{
    
    UIButton *Btn = (UIButton *)sender;
    int groupid = Btn.tag;
  
    nextsv.hidden = NO;
    scrollView.hidden = YES;
    nextsv = [[UIScrollView alloc] init];
    nextsv.frame = CGRectMake(36, 116, 780, 630);
    [self.view addSubview:nextsv];
    [self loadMagezinesNumberWithGroupId:groupid];
    //[nextsv release];
}
//2:点击类别，载入图书列表，分n期显示
-(void)loadMagezinesNumberWithGroupId:(int)groupid{
    
   /* NSError *error;
    NSFetchRequest *request=[[NSFetchRequest alloc] init]; 
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MagazineListPreView" inManagedObjectContext:[self managedObjectContext]]; 
    
    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:
                                      @"(MagazineListPreView.firstName ＝%)"];
    [request setPredicate: predicateTemplate];
    
    [request setEntity:entity];
    */
    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:
                            @"(MagazineListPreView.GroupId ＝%d)",groupid];
    NSArray *magazineNumber=[self retrieveDataWithEntityName:@"MagazineListPreView" fetchLimit:50 predicate:predicateTemplate orderField:@"Period" isAscending:YES inManagedObjectContext:self.managedObjectContext];
                              
     //[[[self managedObjectContext] executeFetchRequest:request error:&error] copy];
    int size = [magazineNumber count];
    
    
   /* NSPredicate *paidPredicateTemplate = [NSPredicate predicateWithFormat:
                                      @"(PaidMagazineList.GroupId ＝%d)",groupid];
    NSArray *paidMagazineNumber=[self retrieveData:@"PaidMagazineList" fetchLimit:50 predicate:predicateTemplate orderField:@"Id" isAscending:YES];
    */
   
    UIButton *Btn;
    UILabel *uiTextView;
    UIImageView *bookshadow;
    UIImageView *bookLine;
    
    for (int i=0; i<size; i++) {
         // for (int j=0; j<[paidMagazineNumber count]; j++) {
        MagazineListPreView* preview=(MagazineListPreView*)[magazineNumber objectAtIndex:i];
        CGRect frame;
        CGRect textFrame; 
        CGRect bookshadowFrame;
        CGRect bookLineFrame;
        Btn = [UIButton buttonWithType:UIButtonTypeCustom]; //retain];
        
        // [Btn setImage:[UIImage imageWithContentsOfFile:[imageNames objectAtIndex: i]] forState:UIControlStateNormal];//设置按钮图片
        
       // NSString *imageName = [NSString stringWithFormat:@"x1.png"];
        UIImage *image = [UIImage imageNamed:preview.MagazineCover];
        //if (i!=11) {
            [Btn setImage:image forState:UIControlStateNormal];
        /*}else
        {
            [Btn setImage:nil forState:UIControlStateNormal];
        }*/
        
        NSString *bgimageName = [NSString stringWithFormat:@"杂志缓冲背景.png"];
        UIImage *bgimage = [UIImage imageNamed:bgimageName];
        [Btn setBackgroundImage:bgimage forState:UIControlStateNormal];
        Btn.tag = preview.MagazineId.intValue;
        
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
        //[Btn release];
        
        
        
        uiTextView=[[UILabel alloc]initWithFrame:textFrame];
        uiTextView.backgroundColor = [UIColor clearColor];
        
        [uiTextView setText:[NSString stringWithFormat:@"第%d期",preview.Period]];       //[imageNames objectAtIndex: i]];
        uiTextView.textColor = [UIColor colorWithRed:193/255.0f green:193/255.0f blue:193/255.0f alpha:1];
        uiTextView.textAlignment = UITextAlignmentLeft;
        uiTextView.font = [UIFont systemFontOfSize:14];
        [nextsv addSubview:uiTextView];
        //[uiTextView release];
        
        bookshadow = [[UIImageView alloc] initWithFrame:bookshadowFrame];
        bookshadow.image = [UIImage imageNamed:@"建筑书刊阴影_137x34.png"];
        [nextsv addSubview:bookshadow];
        //[bookshadow release];
        
        bookLine = [[UIImageView alloc] initWithFrame:bookLineFrame];
        bookLine.image = [UIImage imageNamed:@"图书横向分隔条.png"];
        //bookLine.alpha = 0.6f;
        [nextsv addSubview:bookLine];
        //[bookLine release];
    }
    //}
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
int singeView_hidden = 0;

//点击某期杂志
-(void)MagezinesPressed:(id)sender{
    
    UIButton *Btn = (UIButton *)sender;
    
    int magazineId = Btn.tag;//杂志id
      if (singeView_hidden ) {
          //隐藏
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
            {//显示
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
                [self loadSingeMagezinesWithId:magazineId];
                
               // [signesv release];
            }
}

-(void)loadSingeMagezinesWithId:(int)magazineId{
    //载入单本杂志，显示购买／下载／阅读  显示缩略图
/*    choosedMagazine=magazineId;
    NSPredicate *magazineDetails = [NSPredicate predicateWithFormat:
                                          @"(MagazineDetails.MagazineId ＝%d)",magazineId];
    NSArray *magazineDetailList=[self retrieveData:@"MagazineDetails" fetchLimit:1 predicate:magazineDetails orderField:@"MagazineId" isAscending:YES inManagedObjectContext:self.managedObjectContext];
   
    MagazineDetails *detail=[magazineDetailList objectAtIndex:0];
    
    
    NSPredicate *payedMagazinePre = [NSPredicate predicateWithFormat:
                                    @"(PaidMagazineList.MagazineId ＝%d)",magazineId];
    NSArray *payedMagazinelList=[self retrieveData:@"PaidMagazineList" fetchLimit:1 predicate:payedMagazinePre orderField:@"MagazineId" isAscending:YES inManagedObjectContext:self.managedObjectContext];
    
    //PaidMagazineList *paidMagazine=[payedMagazinelList objectAtIndex:0];
    if ([payedMagazinelList count]>0) {
        PaidMagazineList *paidMagazine=[payedMagazinelList objectAtIndex:0];
        if (paidMagazine.IsExsist.intValue==1) {//存在
            [paybutton setTitle:@"阅读" forState:UIControlStateNormal];
            //paybutton.tag=paidMagazine.MagazineId.intValue;
            [paybutton  addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [paybutton setTitle:@"下载" forState:UIControlStateNormal];
            [paybutton  addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
        }
       
    }
    else
    {
        [paybutton setTitle:@"购买" forState:UIControlStateNormal];
        [paybutton  addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    NSString *detailcovers=detail.ContentImages;
    
    NSArray  *array= [detailcovers componentsSeparatedByString:@","];
    *//*
     NSPredicate *paidPredicateTemplate = [NSPredicate predicateWithFormat:
     @"(PaidMagazineList.MagazineId ＝%d)",magazineId];
     NSArray *paidMagazineNumber=[self retrieveData:@"PaidMagazineList" fetchLimit:1 predicate:paidPredicateTemplate orderField:@"MagazineId" isAscending:YES];
     */
    /*
    description.text=detail.Description;
    [cover setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", detail.MagazineCover]]];
    [priceLabel setText:[NSString stringWithFormat:@"%d", detail.Price.intValue]];
    [groupLabel setText:detail.GroupName];
    
    
    UIImageView *bookTitleshadow;
    int size = [array count];
    
    //MagazineDetails
    
    for (int i=0; i<size; i++) {
        CGRect bookTitleshadowhadowFrame;
        bookTitleshadowhadowFrame.size.width = bookTitleshadowWidth;
        bookTitleshadowhadowFrame.size.height = bookTitleshadowHeight;
        bookTitleshadowhadowFrame.origin.x = (i%2)*(bookTitleshadowWidth+bookTitleMagazineViewXGap)
        +bookTitleMagazineViewToTopLeft;
        
        bookTitleshadowhadowFrame.origin.y = floor(i/2)*(bookTitleshadowHeight+bookTitleMagazineViewYGap)
        +bookTitleMagazineViewToTopTop;
        
        bookTitleshadow = [[UIImageView alloc] initWithFrame:bookTitleshadowhadowFrame];
        bookTitleshadow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[array objectAtIndex:i]]];
        bookTitleshadow.userInteractionEnabled = YES;
        [signesv addSubview:bookTitleshadow];
        [bookTitleshadow release];
        
    }
    
    
    int mainfloor=size/2;
    int ifaddone=size%2==0?0:1;
    int height=(mainfloor+ifaddone)*(bookTitleshadowHeight+bookTitleMagazineViewYGap)+bookTitleMagazineViewToTopTop;
    [signesv setContentSize:CGSizeMake(512, height)];
    [signesv setBackgroundColor:[UIColor clearColor]];*/
}



/*-(IBAction)downloadPaidMagazineWithId:(id)sender{
    UIButton *bt=(UIButton *)sender;
}*/
-(void)read{
  // choosedMagazine
    self.tabBarController.selectedIndex=2;
    //NSArray *vc=self.tabBarController.viewControllers;
   // BaseViewController *readercontroll= [vc objectAtIndex:2];
    //readercontroll.choosedMagazine=choosedMagazine;
    //[self MagezinesPressed:sender];
}

-(void)download{
   //choosedMagazine  
}


/*will update next version webservice*/
-(void)pay{
   //choosedMagazine
    
}

/*订阅*/


-(IBAction)clickcategorys:(id)sender{

}
-(IBAction)Magezines:(id)sender
{
    scrollView.hidden = NO;
    nextsv.hidden = YES;
    nextsv = nil;
    //[self loadMagezines];
}

//购买图书
-(Boolean)buyMagazineById:(int)magazineid{
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    }
    //NSLog(@"MagazineId ＝= %d",  magazineid);
    //查找
    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:@"MagazineId = %d", magazineid];
    
    NSMutableArray *prelist=[self retrieveDataWithEntityName:@"MagazineListPreView" fetchLimit:1 predicate:predicateTemplate orderField:nil isAscending:NO inManagedObjectContext:self.managedObjectContext];
    MagazineListPreView *mgzlp=(MagazineListPreView *)[prelist objectAtIndex:0];
    
    /*  NSLog(@"mgzlp %@,%d,%@,%d,%d,%@",mgzlp.MagazineCover,
     mgzlp.MagazineId.intValue,
     mgzlp.MType, 
     mgzlp.Period.intValue,
     
     mgzlp.GroupId.intValue,
     mgzlp.GroupName);*/
    
    
    
    PaidMagazineListPreView *paidmgzlp=(PaidMagazineListPreView *)[NSEntityDescription insertNewObjectForEntityForName:@"PaidMagazineListPreView" inManagedObjectContext:[self managedObjectContext]];
    
    paidmgzlp.MagazineCover=mgzlp.MagazineCover;
    paidmgzlp.MagazineId=mgzlp.MagazineId;
    paidmgzlp.Mtype=mgzlp.MType;
    paidmgzlp.Period=mgzlp.Period;
    
    paidmgzlp.GroupId=mgzlp.GroupId;
    paidmgzlp.GroupName=@"nouse";//mgzlp.GroupName;
    paidmgzlp.isExsisit=[NSNumber numberWithInt:0];
    
    
    /*NSMutableArray *paidlist=[self retrieveDataWithEntityName:@"" fetchLimit:1 predicate:predicateTemplate orderField:nil isAscending:NO inManagedObjectContext:self.managedObjectContext];
     */
    
    NSError *error;
    if (![[self managedObjectContext] save:&error]) { 
        
        NSLog(@"error!"); 
        
        return CommandFailure;
        [error description];
    }else { 
        NSLog(@"save  ok."); 
        return CommandOk;
    }
}


#pragma mark - View lifecycle
-(void)writeToFileWithMagazineId:(NSString *)magazineid{
    //对于错误信息
    /*NSError *error;
    // 创建文件管理器
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    
    
    NSString *fileDirectoryPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"testpath1"];
    [[NSFileManager defaultManager]   createDirectoryAtPath:fileDirectoryPath  withIntermediateDirectories:YES attributes:nil error:&error ];
    
    
    NSString *filePath= [fileDirectoryPath 
                         stringByAppendingPathComponent:@"file3.txt"];
    //需要写入的字符串
    NSString *str= @"iPhoneDeveloper Tips\nhttp://iPhoneDevelopTips,com";
    //写入文件
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];*/
    //显示文件目录的内容
//    NSLog(@"Documentsdirectory: %@",[fileMgr contentsOfDirectoryAtPath:filePath error:&error]);
    
}

-(void)silderButton{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    //初次或者有网络连接
    if ([self isconnectok]) {
        //连接并解压和显示
        [self synchronizeApp];
        [self loadMagezines];
    }else{
        [self loadMagezines];
    }
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
