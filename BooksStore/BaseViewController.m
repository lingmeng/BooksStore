//
//  BaseViewController.m
//  BookStore
//
//  Created by meng ling on 11-11-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "ASINetworkQueue.h"
@implementation BaseViewController
@synthesize managedObjectContext,choosedMagazineId,mtalist,articleslist,pageslist,contentList;
UILabel *uilabel;
int oldlversion=0;
int oldgversion=0;
int newlversion=0;
int newgversion=0;
int groupsuccess=0;
int listsuccess=0;
NSString *groupurl;
NSString *groupxmlurl;
NSString *bookurl;
NSString *bookxmlurl;
NSString *baseurl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - page

- (id)initWithPageNumber:(int)page {
    /*if (page==0) {
        if (self = [super initWithNibName:@"FrontCoverView" bundle:nil])
        {// NSLog(@"iiiFrontCoverView count:%d",[self retainCount]);
            pageNumber = page; return self;
        }
    }*/
    if (self = [super initWithNibName:@"BaseViewController" bundle:nil])
    {
        
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) hideTabBar:(BOOL) hidden
{  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    //NSLog(@"count: %d",[self.tabBarController.view.subviews count]);
    
   /* if (self.view.tag==9991) {
       //NSLog(@"count: %d",[self.tabBarController.view.subviews count]);
        //[NSLog(@"count: %d",[self.tabBarController.view.subviews count]);
       // NSLog(@"aabb");
        for(UIView *view2 in self.tabBarController.view.subviews){
              
            for(UIView *view in view2.subviews)
           // NSLog([view class])
            if([view isKindOfClass:[UITabBar class]])
            {
               // NSLog(@"bb");
                if (hidden) {
                   // NSLog(@"bbcc");
                    [view setFrame:CGRectMake(view.frame.origin.x, 768, view.frame.size.width, view.frame.size.height)];
                } else {
                   // NSLog(@"bbdd");
                    [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
                }
            } 
        }
    }
    
    else
    {*/
    
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
       // NSLog(@"bbyy");
       // view.backgroundColor=[UIColor redColor];
        if([view isKindOfClass:[UITabBar class]])
        {
          //  NSLog(@"bbmm");
            if (hidden) {
               // NSLog(@"bbzz");
                [view setFrame:CGRectMake(view.frame.origin.x, 768, view.frame.size.width, view.frame.size.height)];
            } else {
              //  NSLog(@"bbxx");
              
                [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
            }
        } 
        else 
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 768)];
            } else {
                
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 768-49)];
            }
        }
        
    //}
}
    [UIView commitAnimations];
}
bool ishidden=NO;
-(void)hideBar{
    
    if (ishidden) {
        
        [self hideTabBar:NO];
        ishidden=NO;
    }
    else
    { 
        
        [self hideTabBar:YES];
        ishidden=YES;
    }
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    [super viewDidLoad];
   /* [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(synchronizeApp) 
                                                 name:UIApplicationDidBecomeActiveNotification 
                                               object:nil];
*/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
	return NO;
}

-(void)dealloc{
    //[request clearDelegatesAndCancel];
    //[request release];
    [baseurl release];
    [super dealloc];
}

#pragma mark - on touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   //  NSLog(@"touch view++++++");
    /*NSSet *allTouches = [event allTouches];
    UITouch *touch = [touches anyObject];
    
    NSLog(@"touch view++++++%@", [touch view]);*/
    //[self hideBar];
//    NSLog(@"touch view++++++--");
    // [touch view]获得当前touch的view
    
    //[allTouches count]获得当前touch的是否是多触摸，如果 [allTouches count] == 1就不是多触摸。
    
}



//是指触摸移动时，调touchesMoved

#define ZOOM_IN_TOUCH_SPACING_RATIO       (0.75)
#define ZOOM_OUT_TOUCH_SPACING_RATIO      (1.5)

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //获取当前touch的点
   // CGPoint location = [touch locationInView:self];
   /* 
    switch ([allTouches count])
    {
        case 1: 
        {
        }
            break;
        case 2: 
        {
            UITouch *touch0 = [[allTouches allObjects] objectAtIndex:0];
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:1];
            CGFloat spacing = 
            [self eucledianDistanceFromPoint:[touch0 locationInView:self] 
                                     toPoint:[touch1 locationInView:self]];
            CGFloat spacingRatio = spacing / lastTouchSpacing_;
            
            if (spacingRatio >= ZOOM_OUT_TOUCH_SPACING_RATIO){
                [self zoomIn]; 
                
            }
            else if (spacingRatio <= ZOOM_IN_TOUCH_SPACING_RATIO) {
                [self zoomOut];
            }
        }
            break;
        default:
            break;
    }
    */
}



//结束时调用touchesEnded

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}


#pragma mark - download and sychronize
/*程序同步主方法 需要同步则下载文件，然后写数据库，最后更新系统版本号，最后给出更新成功实例*/
bool flag=1;
-(void)synchronizeApp{
    int i=[self needSychronize];
    
    if (i==NeedUpdateBookStore) {
        if (!uilabel) {
            uilabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300, 1024, 20)];
        }
        loadok=0;
        //[self downloadGroupFiles];
        [self downloadBookListFiles];
        //[self writeVersionToSystemWithType:NeedUpdateALL];
        [uilabel setText:@"杂志列表已更新！"];
        [self showMessageAnimationatView];
        [self.view addSubview:uilabel];
         [uilabel release];
    }else if(i==NeedUpdateNothing){
        loadok=1;
        //[uilabel setText:@"杂志组和杂志列表已是最新！"];
        //[progressInd stopAnimating];
        //[progressInd removeFromSuperview];
    }
    
    //[self.view.window addSubview:uilabel];
    
   
    //[uilabel removeFromSuperview];
}

//动画
-(void)showMessageAnimationatView{
    if (flag) {
        [uilabel setAlpha:0.0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:2.0f];
        [uilabel setAlpha:1.0];
        [UIView setAnimationDidStopSelector:@selector(showMessageAnimationatView)];
        flag=!flag;
        [UIView setAnimationDelegate:self]; 
        [UIView commitAnimations];
    }
    else{
        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0f]]; 
        [uilabel setAlpha:1.0];
        //[self.window addSubview:uilabel];
        [UIView beginAnimations:nil context:NULL];
	    [UIView setAnimationDuration:2.0f];
        [uilabel setAlpha:0.0];
        flag=!flag;
        [UIView commitAnimations];
        
    }
    
}
- (NSString *)getDocumentDirectory {  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
    return [paths objectAtIndex: 0];  
} 
//开启同步sychronizedAndSaveToDB
-(NSInteger)needSychronize{
    /*
     <VERSION>
     <BOOKSTOREVERSION>1
     </BOOKSTOREVERSION>
     <BOOKSTOREGROUPVERSION>1
     </BOOKSTOREGROUPVERSION>
     <VERSION>
     */
    //NSError* error;
    NSString *xmlFromServ=@"<VERSION><BOOKSTOREVERSION>1</BOOKSTOREVERSION><BOOKSTOREGROUPVERSION>1</BOOKSTOREGROUPVERSION></VERSION>";
    TBXML *tbXml2 = [TBXML tbxmlWithXMLString:xmlFromServ];
    TBXMLElement *root = tbXml2.rootXMLElement;
    TBXMLElement *BOOKSTOREVERSION = [TBXML childElementNamed:@"BOOKSTOREVERSION" parentElement:root];
    //TBXMLElement *BOOKSTOREGROUPVERSION = [TBXML childElementNamed:@"BOOKSTOREGROUPVERSION" parentElement:root];
    
    NSNumber *serv=(NSNumber *)[TBXML textForElement:BOOKSTOREVERSION];
    //NSNumber *servg=(NSNumber *)[TBXML textForElement:BOOKSTOREGROUPVERSION];
    newlversion=serv.intValue;
    //newgversion=servg.intValue;
    
    //获取本机版本号
   // NSString *documentDirectory = [self getDocumentDirectory];  
    
  //  NSString *fileName = @"BSysVersion.plist";  
    //NSString *finalPath;// = [documentDirectory stringByAppendingPathComponent: fileName];  
    
    /*NSLog(@"document finalPath %@",finalPath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        finalPath = [[NSBundle mainBundle] pathForResource:@"BSysVersion" ofType:@"plist"];
    }*/
    
   // NSLog(@"BSysVersion %@",finalPath);
    //NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:finalPath];
    //NSMutableDictionary *topRoot = [[NSMutableDictionary alloc] initWithContentsOfFile: finalPath];  
    
    //根据版本号判断是否需要同步
    NSNumber *bsv=(NSNumber *)[[NSUserDefaults standardUserDefaults]objectForKey:@"BookStoreVersion"];//(NSNumber *)[topRoot objectForKey:@"BookStoreVersion"];
   // NSNumber *bsgv=(NSNumber *)[[NSUserDefaults standardUserDefaults]objectForKey:@"BookStoreGroupVersion"];//(NSNumber *)[topRoot objectForKey:@"BookStoreGroupVersion"];
    
    oldlversion=bsv.intValue;
    //oldgversion=bsgv.intValue;
    
   // NSLog(@"serv %d",[serv intValue]);
   /* if (([serv intValue]>[bsv intValue])&&([servg intValue]>[bsgv intValue])) {
        //NSLog(@"need update bookstore");
        return NeedUpdateALL;//类型和杂志均需更新
    }
    else if ([servg intValue]>[bsgv intValue]) {
        return NeedUpdateBookStoreGroup;//类型需更新
    }
    else if ([serv intValue]>[bsv intValue]) {
        return NeedUpdateBookStore;//杂志需更新
    }
    else 
        return NeedUpdateNothing;//无需更新
    */
    
    //判断是否更新书城
    if ([serv intValue]>[bsv intValue]) {
        return NeedUpdateBookStore;
    }
    else
        return NeedUpdateNothing;
}

-(Boolean)sychronizeGroup{
    //首先下载文件，然后更新数据库，最后重写版本号
    /*
     <GROUPLIST>
     <GROUP>
     <GROUPID>1</GROUPID>
     <GROUPNAME>世界建筑导报</GROUPNAME>
     <GROUPCOVER>fengmianxiao.png</GROUPCOVER>
     </GROUP>
     <GROUP>
     <GROUPID>2</GROUPID>
     <GROUPNAME>其他杂志</GROUPNAME>
     <GROUPCOVER>tu1.png</GROUPCOVER>
     </GROUP>
     <GROUPLIST>
     */
    //类别
    /*
     http://www.5dscape.cn/ArchiBooks/G1/group.xml
     http://www.5dscape.cn/ArchiBooks/G1/fengmianxiao.jpg
     http://www.5dscape.cn/ArchiBooks/G1/tu1.jpg
     
     http://www.5dscape.cn/ArchiBooks/G1/group.zip
     groupurl 
    */
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        //NSLog(@"base managedObjectContext: %@",  self.managedObjectContext);
    }
    
    groupxmlurl=[NSString stringWithFormat:@"%@/G%d/group.xml",DownloadROOTURL,newgversion];
    
    TBXML *groupXml =[TBXML tbxmlWithURL: [NSURL URLWithString: groupxmlurl]]; //[TBXML tbxmlWithXMLString:groupXML];
    TBXMLElement *grouproot = groupXml.rootXMLElement;
    
    TBXMLElement *groups=[TBXML childElementNamed:@"GROUP" parentElement:grouproot];
    while (groups != nil) {
        TBXMLElement *GROUPID = [TBXML childElementNamed:@"GROUPID" parentElement:groups];
        TBXMLElement *GROUPNAME = [TBXML childElementNamed:@"GROUPNAME" parentElement:groups];
        TBXMLElement *GROUPCOVER = [TBXML childElementNamed:@"GROUPCOVER" parentElement:groups];
      //  NSLog(@">>start app "); 
        MagazineGroup *mg=(MagazineGroup *)[NSEntityDescription insertNewObjectForEntityForName:@"MagazineGroup" inManagedObjectContext:[self managedObjectContext]]; 
        mg.GroupId=[NSNumber numberWithInt:[TBXML textForElement:GROUPID].intValue];//@"张三";
    
        mg.GroupName=[TBXML textForElement:GROUPNAME];
        mg.GroupCover=[TBXML textForElement:GROUPCOVER];
        mg.GVersion=[NSNumber numberWithInt:newgversion];
        
        
        // NSLog(@"%@",[TBXML textForElement:GROUPNAME]);
        groups=[TBXML nextSiblingNamed:@"GROUP" searchFromElement:groups];
    }
    NSError *error;
    if (![[self managedObjectContext] save:&error]) { 
        return CommandFailure;
        NSLog(@"error!"); 
    }else { 
        NSLog(@"save  ok."); 
        return CommandOk;
    }
    
}
-(Boolean)sychronizeBooks{
    
    //[TBXML elementName:@"GROUP"]
    
    /*
     <MAGAZINELIST>
     
     <MAGAZINE>
     <GROUPID>1</GROUPID>
     <MAGAZINECOVER>sjjz1.png</MAGAZINECOVER>
     <SMALLIMAGES>sjjz1.png</SMALLIMAGES>
     <MAGAZINEID>1</MAGAZINEID>
     <PERIOD>1</PERIOD>
     <PRICE>12.00</PRICE>
     <MTYPE>1</MTYPE>
     </MAGAZINE>
     
     <MAGAZINE>
     <GROUPID>1</GROUPID>
     <MAGAZINECOVER>sjjz2.png</MAGAZINECOVER>
     <SMALLIMAGES>sjjz2.png</SMALLIMAGES>
     <MAGAZINEID>1</MAGAZINEID>
     <PERIOD>2</PERIOD>
     <PRICE>12.10</PRICE>
     <MTYPE>1</MTYPE>
     </MAGAZINE>
     
     <MAGAZINE>
     <GROUPID>1</GROUPID>
     <MAGAZINECOVER>sjjz3.png</MAGAZINECOVER>
     <SMALLIMAGES>sjjz3.png</SMALLIMAGES>
     <MAGAZINEID>1</MAGAZINEID>
     <PERIOD>3</PERIOD>
     <PRICE>12.00</PRICE>
     <MTYPE>1</MTYPE>
     </MAGAZINE>
     
     </MAGAZINELIST>
     */
    //图书列表
   // NSString *magazineXML=@"<MAGAZINELIST><MAGAZINE><GROUPID>1</GROUPID><MAGAZINECOVER>cover1.png</MAGAZINECOVER><SMALLIMAGES>small01png</SMALLIMAGES><MAGAZINEID>1</MAGAZINEID><PERIOD>1</PERIOD><PRICE>10.0</PRICE><MTYPE>S</MTYPE></MAGAZINE></MAGAZINELIST>";
    
    bookxmlurl=[NSString stringWithFormat:@"%@/B%d/books.xml",DownloadROOTURL,newlversion];
    
   // NSLog(@"===%@",bookxmlurl);
    
    TBXML *magazine = [TBXML tbxmlWithURL: [NSURL URLWithString: bookxmlurl]];
    TBXMLElement *magazineroot = magazine.rootXMLElement;
    
    TBXMLElement *magazines=[TBXML childElementNamed:@"MAGAZINE" parentElement:magazineroot];
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
      //  NSLog(@"base managedObjectContext: %@",  self.managedObjectContext);
    }

    while (magazines != nil) {
        TBXMLElement *GROUPID = [TBXML childElementNamed:@"GROUPID" parentElement:magazines];
        TBXMLElement *MAGAZINECOVER = [TBXML childElementNamed:@"MAGAZINECOVER" parentElement:magazines];
        TBXMLElement *SMALLIMAGES = [TBXML childElementNamed:@"SMALLIMAGES" parentElement:magazines];
        TBXMLElement *MAGAZINEID = [TBXML childElementNamed:@"MAGAZINEID" parentElement:magazines];
        TBXMLElement *PERIOD = [TBXML childElementNamed:@"PERIOD" parentElement:magazines];
        TBXMLElement *PRICE = [TBXML childElementNamed:@"PRICE" parentElement:magazines];
        TBXMLElement *MTYPE = [TBXML childElementNamed:@"MTYPE" parentElement:magazines];
        
        MagazineListPreView *mgzlp=(MagazineListPreView *)[NSEntityDescription insertNewObjectForEntityForName:@"MagazineListPreView" inManagedObjectContext:[self managedObjectContext]];
        // mg.GroupId=[NSNumber numberWithInt:[TBXML textForElement:GROUPID].intValue];
        
        mgzlp.GroupId=[NSNumber numberWithInt:[TBXML textForElement:GROUPID].intValue];
        mgzlp.MagazineCover=[TBXML textForElement:MAGAZINECOVER];
        mgzlp.SmallImages=[TBXML textForElement:SMALLIMAGES];
        mgzlp.MagazineId=[NSNumber numberWithInt:[TBXML textForElement:MAGAZINEID].intValue];
        mgzlp.Period=[NSNumber numberWithInt:[TBXML textForElement:PERIOD].intValue];
        mgzlp.Price=[NSNumber numberWithInt:[TBXML textForElement:PRICE].intValue];
        mgzlp.MType=[TBXML textForElement:MTYPE];
        mgzlp.LVersion=[NSNumber numberWithInt:newlversion];
        
      //  NSLog(@"GroupId %@,MagazineCover %@,SmallImages %@,MagazineId %@,Period %@,Price %@ ",[TBXML textForElement:GROUPNAME]);
        magazines=[TBXML nextSiblingNamed:@"MAGAZINE" searchFromElement:magazines];
    }
    NSError *error;
    if (![[self managedObjectContext] save:&error]) { 
       // NSLog(@"description %@",[error description]);
        
        return CommandFailure;
        NSLog(@"error!"); 
    }else { 
        NSLog(@"save  ok."); 
        return CommandOk;
    }
}
-(Boolean)saveMagezineXmlWithBookId:(int)bookID{
    NSString *booknxmlurl=[NSString stringWithFormat:@"%@/Book%d/Book%d.xml",DownloadROOTURL,bookID,bookID];
   
    /*
      <MAGAZINE MAGAZINEID="1"> 
          <ARTICLE ID="0" BACKGROUND="0001sh.jpg" DESC="世界建筑导报"  KeyWords="aaa"> 
            <PAGE ID="1" BACKGROUND="0001bh.jpg"></PAGE>
          </ARTICLE>
      </MAGAZINE>
     
     
     <ARTICLES MAGAZINEID="1">   MAGAZINEID 杂志唯一标识，每期不同，使用数字
     <ARTICLE ID="1" BACKGROUND="a.png"  KeyWords=\"aaa\>   ID 文章唯一标识，所有文章均不同  BACKGROUND 文章特征缩略图用于显示页面下方的滑动页，一般为文章首页
     <PAGE ID="101" BACKGROUND="0101bh.png">  BACKGROUND 文章内容页
     PSTARTX 热点区域开始X PSTARTY="0" 热点区域开始Y WIDTH="200"热点区域宽 HEIGHT="300"热点区域高 HTYPE="HMAP" 热点类型：地图 LATITUDE="" 纬度 LONGITUDE="" 经度
     <HOTPOINT PSTARTX="0" PSTARTY="0" WIDTH="200" HEIGHT="300" HTYPE="HMAP" LATITUDE="" LONGITUDE=""/>
     </PAGE> 
     <PAGE ID="102" BACKGROUND="b.png">
     HTYPE="HINFOMATION"信息页 文字（全屏式信息）
     <HOTPOINT PSTARTX="0" PSTARTY="0" WIDTH="1024" HEIGHT="748" HTYPE="HINFOMATION" >文字.png</HOTPOINT>
     HTYPE="HSCROLL"信息页 文字（户型图） TYPE 决定纵横 H:横向 V纵向
     <HOTPOINT PSTARTX="0" PSTARTY="0" WIDTH="1024" HEIGHT="748"  HTYPE="HSCROLL" SIZE="3" TYPE="H">A,B,C</HOTPOINT>
     </PAGE>
     </ARTICLE>
     ...多个ARTICLE
     </ARTICLES>
     
    
     
     */
    TBXML *magazinecontent = [TBXML tbxmlWithURL: [NSURL URLWithString: booknxmlurl]];
    TBXMLElement *magazineroot = magazinecontent.rootXMLElement;
    
    TBXMLElement *articles=[TBXML childElementNamed:@"ARTICLE" parentElement:magazineroot];
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        //  NSLog(@"base managedObjectContext: %@",  self.managedObjectContext);
    }
    
    
    
    while (articles != nil) {
        MagazineToArticle *magazineToArticle=(MagazineToArticle *)[NSEntityDescription insertNewObjectForEntityForName:@"MagazineToArticle" inManagedObjectContext:[self managedObjectContext]];
        magazineToArticle.Id=[NSNumber numberWithInt:[TBXML valueOfAttributeNamed:@"ID" forElement:articles].intValue];
        magazineToArticle.ArticleId=[NSNumber numberWithInt:[TBXML valueOfAttributeNamed:@"ID" forElement:articles].intValue];
        magazineToArticle.MagazineId=[NSNumber numberWithInt:[TBXML valueOfAttributeNamed:@"MAGAZINEID" forElement:magazineroot].intValue];
        //MagazineToArticle
        //ArticlePage
        Article *article=(Article *)[NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:[self managedObjectContext]];
        article.Id=[NSNumber numberWithInt:[TBXML valueOfAttributeNamed:@"ID" forElement:articles].intValue];
        article.KeyWords=[TBXML valueOfAttributeNamed:@"KeyWords" forElement:articles];
        article.ContentBgImage=[TBXML valueOfAttributeNamed:@"BACKGROUND" forElement:articles];
        article.Desc=[TBXML valueOfAttributeNamed:@"DESC" forElement:articles];
         TBXMLElement *page=[TBXML childElementNamed:@"PAGE" parentElement:articles];
         while (page != nil) {
             Pages *pages=(Pages *)[NSEntityDescription insertNewObjectForEntityForName:@"Pages" inManagedObjectContext:[self managedObjectContext]];
             //TBXMLElement *PAGEID = (NSNumber *)[TBXML valueOfAttributeNamed:@"Id" forElement:articlePage];
             pages.ArticleId=[NSNumber numberWithInt:[TBXML valueOfAttributeNamed:@"ID" forElement:articles].intValue];
             pages.PageNo=[NSNumber numberWithInt:[TBXML valueOfAttributeNamed:@"ID" forElement:page].intValue];
             pages.ContentBgImage=[TBXML valueOfAttributeNamed:@"BACKGROUND" forElement:page];
             //TBXMLElement *MAGAZINECOVER = [TBXML childElementNamed:@"MAGAZINECOVER" parentElement:page];
             
             page=[TBXML nextSiblingNamed:@"PAGE" searchFromElement:page];
        }
        
        //
        articles=[TBXML nextSiblingNamed:@"ARTICLE" searchFromElement:articles];
    }
    
    NSError *error;
    if (![[self managedObjectContext] save:&error]) { 
        NSLog(@"-- %@",[error description]);
        return CommandFailure;
        NSLog(@"error!"); 
    }else { 
        NSLog(@"save  ok."); 
        return CommandOk;
    }
    /* NSString *articleXML=@"<ARTICLES MAGAZINEID=\"1\"><ARTICLE ID=\"1\" KeyWords=\"aaa\"><PAGE ID=\"101\" ContentBgImage=\"a.png\"><HOTPOINT PSTARTX=\"0\" PSTARTY=\"0\" WIDTH=\"200\" HEIGHT=\"300\" HTYPE=\"HMAP\" LATITUDE=\"\" LONGITUDE=\"\"/></PAGE> <PAGE ID=\"102\" BACKGROUND=\"b.png\"><HOTPOINT PSTARTX=\"0\" PSTARTY=\"0\" WIDTH=\"1024\" HEIGHT=\"748\" HTYPE=\"HINFOMATION\" >文字.png</HOTPOINT><HOTPOINT PSTARTX=\"0\" PSTARTY=\"0\" WIDTH=\"1024\" HEIGHT=\"748\"  HTYPE=\"HSCROLL\" SIZE=\"3\" TYPE=\"H\">A,B,C</HOTPOINT></PAGE></ARTICLE>";
     TBXML *articleXml = [TBXML tbxmlWithXMLString:articleXML];
     TBXMLElement *articleroot = articleXml.rootXMLElement;
     
     TBXMLElement *articlex=[TBXML childElementNamed:@"ARTICLE" parentElement:articleroot];//代表杂志
     while (articlex != nil) {
     //杂志保存文章列表
     MagazineToArticle *magazineToArticle=(MagazineToArticle *)[NSEntityDescription insertNewObjectForEntityForName:@"MagazineToArticle" inManagedObjectContext:[self managedObjectContext]];
     magazineToArticle.MagazineId=[NSNumber numberWithInt:bookid];//[TBXML childElementNamed:@"ARTICLE" parentElement:articleroot];
     magazineToArticle.ArticleId=(NSNumber *)[TBXML valueOfAttributeNamed:@"Id" forElement:articlex];
     
     TBXMLElement *pages=[TBXML childElementNamed:@"PAGE" parentElement:articlex];
     while (pages != nil) {
     //文章内页列表
     Article *articlepage=(Article *)[NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:[self managedObjectContext]];
     articlepage.id=(NSNumber *)[TBXML valueOfAttributeNamed:@"Id" forElement:articlex];
     articlepage.PageNo=(NSNumber *)[TBXML valueOfAttributeNamed:@"Id" forElement:pages];
     articlepage.ContentBgImage=[TBXML valueOfAttributeNamed:@"ContentBgImage" forElement:pages];
     
     
     //热点解析和保存
     TBXMLElement *hotpoints=[TBXML childElementNamed:@"HOTPOINT" parentElement:pages];
     while (hotpoints != nil) {
     HotPoints *hotpoint=(HotPoints *)[NSEntityDescription insertNewObjectForEntityForName:@"HotPoints" inManagedObjectContext:[self managedObjectContext]];
     hotpoint.ArticleId=(NSNumber *)[TBXML valueOfAttributeNamed:@"Id" forElement:articlex];
     hotpoint.PageNo=(NSNumber *)[TBXML valueOfAttributeNamed:@"Id" forElement:pages];
     hotpoint.HotPointType=[TBXML valueOfAttributeNamed:@"HTYPE" forElement:hotpoints];
     hotpoint.HotPointViewStartX=(NSNumber *)[TBXML valueOfAttributeNamed:@"PSTARTX" forElement:hotpoints];
     hotpoint.HotPointViewStartY=(NSNumber *)[TBXML valueOfAttributeNamed:@"PSTARTY" forElement:hotpoints];
     hotpoint.HotPonitViewHeight=(NSNumber *)[TBXML valueOfAttributeNamed:@"WIDTH" forElement:hotpoints];
     hotpoint.HotPonitViewWidth=(NSNumber *)[TBXML valueOfAttributeNamed:@"HEIGHT" forElement:hotpoints];
     if ([hotpoint.HotPointType compare:@"HMAP"]) {
     hotpoint.Latitude=(NSNumber *)[TBXML valueOfAttributeNamed:@"Latitude" forElement:hotpoints];
     hotpoint.Longitude=(NSNumber *)[TBXML valueOfAttributeNamed:@"Longitude" forElement:hotpoints];
     }else if ([hotpoint.HotPointType compare:@"HINFOMATON"]) {
     hotpoint.InfomationImage=[TBXML textForElement:hotpoints];
     }else if ([hotpoint.HotPointType compare:@"HSCROLL"]) {
     hotpoint.ScrollViewImage=[TBXML textForElement:hotpoints];
     hotpoint.ScrollViewRollType=[TBXML valueOfAttributeNamed:@"TYPE" forElement:hotpoints];
     hotpoint.ScrollViewSize=(NSNumber *)[TBXML valueOfAttributeNamed:@"SIZE" forElement:hotpoints];
     }else if([hotpoint.HotPointType compare:@"HVEDIO"]){
     hotpoint.VEDIOADDRESS=[TBXML valueOfAttributeNamed:@"VEDIOADDRESS" forElement:hotpoints];
     
     }
     
     hotpoints=[TBXML nextSiblingNamed:@"HOTPOINT" searchFromElement:hotpoints];
     }
     
     
     
     pages=[TBXML nextSiblingNamed:@"PAGE" searchFromElement:pages];
     }
     
     articlex=[TBXML nextSiblingNamed:@"ARTICLE" searchFromElement:articlex];
     }
     
     
     NSError *error;
     if (![[self managedObjectContext] save:&error]) { 
     return CommandFailure;
     NSLog(@"error!"); 
     }else { 
     NSLog(@"save  ok."); 
     return CommandOk;
     }
     */
    
}

#pragma mark - asihttp


-(Boolean)isconnectok{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            NSLog(@"没有网络");
            return false;
           // break;
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"正在使用3G网络");
            return true;
           // break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"正在使用wifi网络");   
            return true;
           // break;
    }
    return false;
}

UIActivityIndicatorView *progressInd;


-(void)downloadGroupFiles{
    progressInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:
                                          UIActivityIndicatorViewStyleWhiteLarge];
    progressInd.center=CGPointMake(self.view.center.x,748/2);
    [self.view addSubview:progressInd];
    [progressInd startAnimating];

	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
	
    ASIHTTPRequest *request;
     groupurl=[NSString stringWithFormat:@"%@/G%d/group.zip",DownloadROOTURL,newgversion];
    
    NSLog(@"%@",groupurl);
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:groupurl]];
    [request setAllowResumeForFileDownloads:YES];
    //初始化保存ZIP文件路径
	NSString *savePath = [path stringByAppendingPathComponent:@"group.zip"];
    [request setDownloadDestinationPath:savePath];
	//初始化临时文件路径
    [request setDelegate:self];
    [request startSynchronous];
   
    
  
}






-(void)downloadBookListFiles{
    //每期杂志的封面   只在新版文件夹下载   则新版文件夹必须包含老版的各类各期杂志资源
    progressInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:
                 UIActivityIndicatorViewStyleWhiteLarge];
    progressInd.center=CGPointMake(self.view.center.x,748/2);
    [self.view addSubview:progressInd];
    [progressInd startAnimating];
    //G2 =  version2 group
    //初始化Documents路径
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
	
    ASIHTTPRequest *request;
    bookurl=[NSString stringWithFormat:@"%@/B%d/books.zip",DownloadROOTURL,newlversion];
    
    NSLog(@"%@",bookurl);
    //www.5dscape.cn/ArchiBooks/ArchiBooks.tgz
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:bookurl]];
    [request setAllowResumeForFileDownloads:YES];
    
    
    
    //初始化保存ZIP文件路径
	NSString *savePath = [path stringByAppendingPathComponent:@"books.zip"];
    [request setDownloadDestinationPath:savePath];
    [request setDelegate:self];
    [request startSynchronous];
	
    
}



//组或者杂志列表结束时调用
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *str=[NSString stringWithFormat:@"%@%@",BASEURL,[request url].path];
    if (bookurl) {
    if ([str isEqualToString:bookurl]) {//groupsuccess
        NSLog(@"book downloadok");
        if ([self sychronizeBooks]==CommandOk) {
            NSString *path =  [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
            NSString *originFile=[path stringByAppendingPathComponent:@"books.zip"];
            NSString *destFile=[path stringByAppendingPathComponent:@"books"];
            [self unZipFromfilepath:originFile 
                         tofilepath:destFile];
            [self writeVersionToSystemWithType:NeedUpdateBookStore];
            
        }
    } 
    }
    [progressInd stopAnimating];
    [progressInd removeFromSuperview];
    loadok=1;
}

-(void)writeVersionToSystemWithType:(int)uploadtype{
    //NSString *finalPath;// = [documentDirectory stringByAppendingPathComponent: fileName];  
    //if (![[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
       // NSString *finalPath = [[NSBundle mainBundle] pathForResource:@"BooksStore-info" ofType:@"plist"];
    //}
    
    if (NeedUpdateBookStoreGroup==uploadtype) {
       [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:newgversion] forKey:@"BookStoreGroupVersion"]; 
    }
    if (NeedUpdateBookStore==uploadtype) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:newlversion] forKey:@"BookStoreVersion"];
    }
    if (NeedUpdateALL==uploadtype) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:newlversion] forKey:@"BookStoreVersion"];
         [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:newgversion] forKey:@"BookStoreGroupVersion"];
    }
   
    // NSLog(@"llllllnewlgversion %d", [[[NSUserDefaults standardUserDefaults]objectForKey:@"BookStoreGroupVersion"]intValue]);

    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
   // NSLog(@"request err description %@",error.description);
    [progressInd stopAnimating];
    [progressInd removeFromSuperview];
    loadok=1;
}



#pragma mark - coredata fetch
- (NSMutableArray *)retrieveDataWithEntityName: (NSString *)entityName fetchLimit:(int)fetchLimit predicate:(NSPredicate *)predicate  
                      orderField:(NSString *)orderField isAscending:(BOOL)isAscending inManagedObjectContext:(NSManagedObjectContext *)moc
{ 
    NSError *error;
    // Create fetch request for the Entity 
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc]; 
    NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
    [request setEntity:entity]; 
    
    // Constraint 
    if (predicate != nil) { 
        [request setPredicate:predicate]; 
    } 
    
    // Limit 
    if (fetchLimit>0) { 
        [request setFetchLimit:fetchLimit]; 
    } 
    
    // Order 
    if (orderField!=nil) {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:orderField ascending:isAscending]; 
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil]; 
    [request setSortDescriptors:sortDescriptors]; 
    [sortDescriptor release]; 
    [sortDescriptors release]; 
    }
    // Execute the fetch 
    NSMutableArray *arr= [[moc executeFetchRequest:request error:&error] mutableCopy]; 
   
    [request release];
    return arr;
    
} 

-(void)unZipFromfilepath:(NSString *)filePath tofilepath:(NSString *)unZipPath {//解压按键事件
	
	//MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self animated:YES];
	//mbp.labelText = @"   解压中,请等待...   ";
	//初始化Documents路径
	//NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	//设置ZIP文件路径
	//filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d.zip",bookID]];
	//设置解压文件夹的路径
	//unZipPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"book_%d",bookID]];
	//初始化ZipArchive
	ZipArchive *zip = [[ZipArchive alloc] init];
	
	BOOL result;
	
	if ([zip UnzipOpenFile:filePath]) {
		
		result = [zip UnzipFileTo:unZipPath overWrite:YES];//解压文件
		if (!result) {
			//解压失败
			NSLog(@"unzip fail................");
		}else {
			//解压成功
			NSLog(@"unzip success.............");
        }
        
		[zip UnzipCloseFile];//关闭
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *error;
        [fileMgr removeItemAtPath:filePath error:&error]; 
	}
	[zip release];
	
}

@end
