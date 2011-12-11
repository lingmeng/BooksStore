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
@synthesize managedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - download and sychronize
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
    TBXMLElement *BOOKSTOREGROUPVERSION = [TBXML childElementNamed:@"BOOKSTOREGROUPVERSION" parentElement:root];
    
    NSNumber *serv=(NSNumber *)[TBXML textForElement:BOOKSTOREVERSION];
    NSNumber *servg=(NSNumber *)[TBXML textForElement:BOOKSTOREGROUPVERSION];
    

    //获取本机版本号
    NSString *documentDirectory = [self getDocumentDirectory];  
    NSString *fileName = @"BSysVersion.plist";  
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent: fileName];  
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        finalPath = [[NSBundle mainBundle] pathForResource:@"BSysVersion" ofType:@"plist"];
    }
    //NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:finalPath];
    NSMutableDictionary *topRoot = [[NSMutableDictionary alloc] initWithContentsOfFile: finalPath];  
    
    //根据版本号判断是否需要同步
    NSNumber *bsv=(NSNumber *)[topRoot objectForKey:@"BookStoreVersion"];
    NSNumber *bsgv=(NSNumber *)[topRoot objectForKey:@"BookStoreGroupVersion"];
    if (([bsv intValue]==1||[serv intValue]>[bsv intValue])&&([bsgv intValue]==1||[servg intValue]>[bsgv intValue])) {
        //NSLog(@"need update bookstore");
        return NeedUpdateALL;//类型和杂志均需更新
    }
    else if ([bsgv intValue]==1||[servg intValue]>[bsgv intValue]) {
        return NeedUpdateBookStoreGroup;//类型需更新
    }
    else if ([bsgv intValue]==1||[servg intValue]>[bsgv intValue]) {
        return NeedUpdateBookStore;//杂志需更新
    }
    else 
        return NeedUpdateNothing;//无需更新*/
}

-(Boolean)sychronizeGroup{
    /*
     <GROUPLIST>
     <GROUP>
     <GROUPID></GROUPID>
     <GROUPNAME></GROUPNAME>
     <GROUPCOVER></GROUPCOVER>
     <GROUPVERSION></GROUPVERSION>
     </GROUP>
     <GROUPLIST>
     */
    //类别
    NSString *groupXML=@"<GROUPLIST version=\"2\"><GROUP><GROUPID>1</GROUPID><GROUPNAME>世界建筑导报</GROUPNAME><GROUPCOVER>sjjz.png</GROUPCOVER></GROUP><GROUP><GROUPID>2</GROUPID><GROUPNAME>世界建筑导报2</GROUPNAME><GROUPCOVER>sjjz2.png</GROUPCOVER></GROUP></GROUPLIST>";
    TBXML *groupXml = [TBXML tbxmlWithXMLString:groupXML];
    TBXMLElement *grouproot = groupXml.rootXMLElement;
    
    TBXMLElement *groups=[TBXML childElementNamed:@"GROUP" parentElement:grouproot];
    while (groups != nil) {
        TBXMLElement *GROUPID = [TBXML childElementNamed:@"GROUPID" parentElement:groups];
        TBXMLElement *GROUPNAME = [TBXML childElementNamed:@"GROUPNAME" parentElement:groups];
        TBXMLElement *GROUPCOVER = [TBXML childElementNamed:@"GROUPCOVER" parentElement:groups];
        // TBXMLElement *GROUPVERSION = [TBXML childElementNamed:@"GROUPVERSION" parentElement:groups];
        
        NSLog(@">>start app "); 
        MagazineGroup *mg=(MagazineGroup *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:[self managedObjectContext]]; 
        mg.GroupId=(NSNumber *)[TBXML textForElement:GROUPID];//@"张三";
        mg.GroupName=[TBXML textForElement:GROUPNAME];
        mg.GroupCover=[TBXML textForElement:GROUPCOVER];
        /*
         NSFetchRequest *request=[[NSFetchRequest alloc] init]; 
         NSEntityDescription *entity=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:[self managedObjectContext]]; 
         [request setEntity:entity];
         
         NSArray *results=[[[self managedObjectContext] executeFetchRequest:request error:&error] copy];
         
         for (Person *p in results) { 
         NSLog(@">> p.id: %i p.name: %@",p.id,p.name); 
         }*/
        
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
     <GROUPID></GROUPID>
     <MAGAZINECOVER></MAGAZINECOVER>
     <SMALLIMAGES></SMALLIMAGES>
     <MAGAZINEID></MAGAZINEID>
     <PERIOD></PERIOD>
     <PRICE></PRICE>
     <MTYPE></MTYPE>
     </MAGAZINE>
     </MAGAZINELIST>
     */
    //图书列表
    NSString *magazineXML=@"<MAGAZINELIST><MAGAZINE><GROUPID>1</GROUPID><MAGAZINECOVER>cover1.png</MAGAZINECOVER><SMALLIMAGES>small01png</SMALLIMAGES><MAGAZINEID>1</MAGAZINEID><PERIOD>1</PERIOD><PRICE>10.0</PRICE><MTYPE>S</MTYPE></MAGAZINE></MAGAZINELIST>";
    
    TBXML *magazine = [TBXML tbxmlWithXMLString:magazineXML];
    TBXMLElement *magazineroot = magazine.rootXMLElement;
    
    TBXMLElement *magazines=[TBXML childElementNamed:@"MAGAZINE" parentElement:magazineroot];
    while (magazines != nil) {
        TBXMLElement *GROUPID = [TBXML childElementNamed:@"GROUPID" parentElement:magazines];
        TBXMLElement *MAGAZINECOVER = [TBXML childElementNamed:@"MAGAZINECOVER" parentElement:magazines];
        TBXMLElement *SMALLIMAGES = [TBXML childElementNamed:@"SMALLIMAGES" parentElement:magazines];
        TBXMLElement *MAGAZINEID = [TBXML childElementNamed:@"MAGAZINEID" parentElement:magazines];
        TBXMLElement *PERIOD = [TBXML childElementNamed:@"PERIOD" parentElement:magazines];
        TBXMLElement *PRICE = [TBXML childElementNamed:@"PRICE" parentElement:magazines];
        TBXMLElement *MTYPE = [TBXML childElementNamed:@"MTYPE" parentElement:magazines];
        
        MagazineListPreView *mgzlp=(MagazineListPreView *)[NSEntityDescription insertNewObjectForEntityForName:@"MagazineListPreView" inManagedObjectContext:[self managedObjectContext]];
        mgzlp.GroupId=(NSNumber*)[TBXML textForElement:GROUPID];
        mgzlp.MagazineCover=[TBXML textForElement:MAGAZINECOVER];
        mgzlp.SmallImages=[TBXML textForElement:SMALLIMAGES];
        mgzlp.MagazineId=[TBXML textForElement:MAGAZINEID];
        mgzlp.Period=(NSNumber*)[TBXML textForElement:PERIOD];
        mgzlp.Price=(NSNumber*)[TBXML textForElement:PRICE];
        mgzlp.MType=[TBXML textForElement:MTYPE];
        
        // NSLog(@"%@",[TBXML textForElement:GROUPNAME]);
        magazines=[TBXML nextSiblingNamed:@"MAGAZINE" searchFromElement:magazines];
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
-(Boolean)DownloadBooksWithBookId:(int)bookid{
    //http://www.sss.com/downloadbooks/bookid/book.xml
    
    /*
     <ARTICLES MAGAZINEID="1">   MAGAZINEID 杂志唯一标识，每期不同，使用数字
     
     <ARTICLE ID="1" BACKGROUND="a.png">   ID 文章唯一标识，所有文章均不同  BACKGROUND 文章特征缩略图用于显示页面下方的滑动页，一般为文章首页
     <PAGE ID="101" BACKGROUND="a.png">  BACKGROUND 文章内容页
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
    NSString *articleXML=@"<ARTICLES MAGAZINEID=\"1\"><ARTICLE ID=\"1\" KeyWords=\"aaa\"><PAGE ID=\"101\" ContentBgImage=\"a.png\"><HOTPOINT PSTARTX=\"0\" PSTARTY=\"0\" WIDTH=\"200\" HEIGHT=\"300\" HTYPE=\"HMAP\" LATITUDE=\"\" LONGITUDE=\"\"/></PAGE> <PAGE ID=\"102\" BACKGROUND=\"b.png\"><HOTPOINT PSTARTX=\"0\" PSTARTY=\"0\" WIDTH=\"1024\" HEIGHT=\"748\" HTYPE=\"HINFOMATION\" >文字.png</HOTPOINT><HOTPOINT PSTARTX=\"0\" PSTARTY=\"0\" WIDTH=\"1024\" HEIGHT=\"748\"  HTYPE=\"HSCROLL\" SIZE=\"3\" TYPE=\"H\">A,B,C</HOTPOINT></PAGE></ARTICLE>";
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
    
}

-(Boolean)sychronizeWithServ:(int)flag{
     NSString *newversion;
    if (flag==NeedUpdateALL) {
       // MagazineGroup *group=;
        if ([self sychronizeGroup]&&[self sychronizeBooks]) {
            return CommandOk;
        }
        return CommandFailure;
        
    }else if (flag==NeedUpdateBookStoreGroup) {
        if ([self sychronizeGroup]) {
            return CommandOk;
        }
        return CommandFailure;
    }else if (flag==NeedUpdateBookStore) {
        if ([self sychronizeBooks]) {
            return CommandOk;
        }
        return CommandFailure;
    }else {
         return CommandOk;
        
    }
    
    //NSFileManager *fileManager = [NSFileManager defaultManager]; 
    NSString *documentDirectory = [self getDocumentDirectory];  
    NSString *fileName = @"BSysVersion.plist";  
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent: fileName];  
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        finalPath = [[NSBundle mainBundle] pathForResource:@"BSysVersion" ofType:@"plist"];
    }
    //NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:finalPath];
    NSMutableDictionary *topRoot = [[NSMutableDictionary alloc] initWithContentsOfFile: finalPath];  
    
    [topRoot setValue: newversion forKey: @"BookStoreVersion"];
    [topRoot setValue: newversion forKey: @"BookStoreGroupVersion"];
    [topRoot writeToFile: finalPath atomically: NO];  
   // [fileManager createFileAtPath:fileName contents: topRoot attributes:nil];  
    [topRoot release];  
    return YES;
}

#pragma mark - asihttp

- (IBAction)grabURLInBackground:(id)sender
{
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];	
	}
    failed = NO;
    [networkQueue reset];
	[networkQueue setDownloadProgressDelegate:progressIndicator];
	[networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
	[networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
    [networkQueue setDelegate:self];
    
    ASIHTTPRequest *request;
    [request setAllowResumeForFileDownloads:YES];
    //下载图片
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/small-image.jpg"]];
	[request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"1.png"]];
    
    [networkQueue addOperation:request];
    
    
    [networkQueue go];
    /*request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];*/
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    //NSString *responseString = [request responseString];
    
    // Use when fetching binary data
   // NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
   // NSError *error = [request error];
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
    [networkQueue reset];
	[networkQueue release];
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

@end
