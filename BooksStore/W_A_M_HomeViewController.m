//
//  W_A_M_HomeViewController.m
//  World_Architect_Magazine
//
//  Created by fei chen on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "W_A_M_HomeViewController.h"
#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>

double const kPageChangeThreshold = 0.005f;
int const kInitialPrevPage = -1;
int const kPagesAround = 2; // 1 if not care flicker of white edge between pages when scrolling
@implementation UIScrollView (NoQuickDrag)
/**
 * Avoid too fast scroll, pages might not be ready when being
 * scrolled that fast.
 **加边框＊/
leftView.layer.masksToBounds=YES; 
leftView.layer.cornerRadius=2.0; 
leftView.layer.borderWidth=1.0; 
leftView.layer.borderColor=[[UIColor grayColor] CGColor];
 http://www.cocoachina.com/bbs/read.php?tid=86268
 http://www.cocoachina.com/bbs/read.php?tid=86201  
 http://www.cocoachina.com/iphonedev/sdk/2011/1019/3388.html
 */
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if (self.decelerating && self.pagingEnabled) {
		return nil;
	}
	return [super hitTest:point withEvent:event];
}
@end

@implementation W_A_M_HomeViewController
@synthesize weiBoView;
@synthesize articleScrollView;
@synthesize listsv;
@synthesize top_titleView;
@synthesize down_titleView;
@synthesize myPageControl;
@synthesize detailView;
@synthesize detailInfoView;
@synthesize buttonbackView;
@synthesize listbtu,talkbtu,wbbtu,homebtn,infobtu,mapbtu,framebtu,playbtu,leftbtu,rightbtu;
@synthesize currentpage;
@synthesize titlePageArray;
@synthesize editeView;
@synthesize editesv;
@synthesize infoView;
@synthesize infosv;
@synthesize pagesSV;
@synthesize mapVc;
@synthesize moviepVc;
@synthesize framesv;
@synthesize buttonView;
@synthesize viewControllers;
@synthesize player;
@synthesize listbtuname;

NSInteger Articlecurrentpage=0 ;

NSInteger kNumberOfArticle =0;

BOOL letter_hidden = 0 ;
BOOL map_hidden = 0;
BOOL frame_hidden = 0;
BOOL list_hidden = 0;
NSString *smallpath;
NSString *path;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)dealloc
{
    //[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma customer method
-(void)removeLastContentWithIndex:(NSInteger)page {
    if (page < 1)
        return;
    if (page >= kNumberOfArticle)
        return;
    W_A_M_PageScrollView *lastView = (W_A_M_PageScrollView *)[viewControllers objectAtIndex:page];
    if ((NSNull *)lastView != [NSNull null]) {

        [lastView.view removeFromSuperview];
        [self.viewControllers replaceObjectAtIndex:page withObject:[NSNull null]];
    } 
}
//
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     CGFloat pageWidth = scrollView.frame.size.width;
     int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentpage = page;
    if (scrollView == listsv) {
        listsv.contentSize = CGSizeMake((186 * kNumberOfArticle + 66), 160);
    }else
    {
        listsv.contentSize = CGSizeMake((186 * kNumberOfArticle + 66 +429), 160);
        [listsv scrollRectToVisible:CGRectMake(532.0+(186*(page))-1024+93,0,1024.0, 160.0) animated:YES];
        for (int i=0; i<kNumberOfArticle; i++) {
            [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:0.0F];
            [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
            if (page== i) {
                [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:1.0F];
                [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
            }
        }
    }
//.....
    [self removeLastContentWithIndex:page-2]; 
    [self removeLastContentWithIndex:page+2];
//.....
    [self loadScrollViewWithPage:Articlecurrentpage - 1];
    [self loadScrollViewWithPage:Articlecurrentpage];
    [self loadScrollViewWithPage:Articlecurrentpage + 1];
}

- (void)loadScrollViewWithPage:(int)page{
    if (page < 1)
        return;
    if (page >= kNumberOfArticle)
        return;

    W_A_M_PageScrollView *controller = [viewControllers objectAtIndex:page];
    
    if ((NSNull *)controller == [NSNull null])
    {
        //controller = [[W_A_M_PageScrollView alloc]PagesLoadView:page];
        controller=[[W_A_M_PageScrollView alloc] initWithNibName:@"W_A_M_PageScrollView" bundle:[NSBundle mainBundle]];
        controller.titlePages = page;
        controller.pageslist=self.pageslist;//最好是字典，这里是所有的页；
        controller.articleslist=self.articleslist;//所有的文章，可取缩略图;
        controller.contentList=self.contentList;//字典
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        //[controller release];
    }
    if (controller.view.superview == nil)
    {
        //NSLog(@"dsdsd");
        CGRect frame = articleScrollView.frame;
        frame.origin.x = 1024 * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        controller.view.userInteractionEnabled = YES;
        [articleScrollView addSubview:controller.view];
    } 
}
#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
        
    [super viewWillAppear:animated];
    self.mtalist=[[NSMutableArray alloc] init];
    self.articleslist=[[NSMutableArray alloc] init];
    self.pageslist=[[NSMutableArray alloc] init];
    self.contentList=[[NSMutableArray alloc] init];
    path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/BookContent/Book1/sjjzdb/134ch/chapter/"];
    smallpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/BookContent/Book1/sjjzdb/134ch/small/"];
    NSLog(@"chooseMagazineID %d",self.choosedMagazineId);
    
    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:@"(MagazineId=%d)",  self.choosedMagazineId];
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(BooksStoreAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    }
    NSMutableArray *mta1=[self retrieveDataWithEntityName:@"MagazineToArticle" fetchLimit:-1 predicate:predicateTemplate orderField:@"Id" isAscending:YES inManagedObjectContext:self.managedObjectContext];
    for (int i=0;i<[mta1 count]; i++) {
        MagazineToArticle *mt=(MagazineToArticle *)[mta1 objectAtIndex:i];
        [[NSMutableArray alloc] init];
        [self.mtalist addObject: mt.ArticleId];
    }
    
    //一组articleid,显示导航小图
    NSPredicate *articlepredicate = [NSPredicate predicateWithFormat:@"Id IN %@",[NSArray arrayWithArray:self.mtalist]];
    self.articleslist=[self retrieveDataWithEntityName:@"Article" fetchLimit:-1 predicate:articlepredicate orderField:nil isAscending:NO inManagedObjectContext:self.managedObjectContext];
    NSLog(@"articles size count navimage %d",[self.articleslist count]);
    kNumberOfArticle=[self.articleslist count];
   
    NSPredicate *pagepredicate = [NSPredicate predicateWithFormat:@"ArticleId IN %@",self.mtalist];
    
    //一组articleid，显示页面
    self.pageslist=[self retrieveDataWithEntityName:@"Pages" fetchLimit:-1 predicate:pagepredicate orderField:@"ArticleId" isAscending:YES inManagedObjectContext:self.managedObjectContext];
    NSLog(@"TotalPages size count image %d",[self.pageslist count]);
    currentpage = 0;
    
    //组装翻页dictionary
     
    for (int i=0; i<[self.articleslist count]; i++) {
        NSMutableDictionary *articledoc = [NSMutableDictionary dictionary];
        Article *article=[[self articleslist]objectAtIndex:i];
        //ArticleVO *vo=[[ArticleVO alloc]init];
        //vo.Pages=article 
        int pagecount=0;
        for (int k=0; k<[self.pageslist count]; k++) {
            Pages *pg=(Pages *)[[self pageslist]objectAtIndex:k];
            if (pg.ArticleId.intValue==article.Id.intValue) {
                pagecount++;
                 [articledoc setObject:[path stringByAppendingPathComponent:pg.ContentBgImage] forKey:[NSString stringWithFormat:@"%d",pg.PageNo.intValue]];
            }
        }
        [articledoc setObject:[NSString stringWithFormat:@"%d",pagecount] forKey:@"Pages"]; 
        [articledoc setObject:[smallpath stringByAppendingPathComponent:article.ContentBgImage] forKey:@"imageKey"];
        [self.contentList addObject:articledoc]; 
    
    }
    //解析热点报文组装翻页热点
    
    
    
    
    articleScrollView.contentSize = CGSizeMake(1024* kNumberOfArticle,748 );
    articleScrollView.backgroundColor = [UIColor blackColor];
    articleScrollView.pagingEnabled = YES;
    articleScrollView.showsHorizontalScrollIndicator = NO;
    articleScrollView.showsVerticalScrollIndicator = NO;
    articleScrollView.delegate = self;
    articleScrollView.userInteractionEnabled = YES;  
    articleScrollView.scrollEnabled = YES;
    articleScrollView.canCancelContentTouches = YES;
    articleScrollView.bounces = YES;
    articleScrollView.delaysContentTouches = NO;
    articleScrollView.directionalLockEnabled = YES;
    articleScrollView.alwaysBounceVertical = NO;
    articleScrollView.tag = 10001;
    
    //根据 choosedmagazineid读取页面 
    
    buttonView.tag = 505;
    //MagazineToArticle Article Pages
    
   
    
    
    //取封面 
    NSString* imagePath;
    for (int i=0; i<[self.pageslist count]; i++) {
        Pages *pgs=(Pages *)[self.pageslist objectAtIndex:i];
        if (pgs.PageNo.intValue==1&&pgs.ArticleId.intValue==0) {
            //NSLog(@"image %@",[path stringByAppendingPathComponent:pgs.ContentBgImage] );
            imagePath=[path stringByAppendingPathComponent:pgs.ContentBgImage];
            break;
        }
    }
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfArticle; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    //[controllers release];
    
    //article
    //NSLog(@"imagepath %@",imagePath);
    CGRect viewFrame = CGRectMake(0, 0, 1024, 748);
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:viewFrame];
    //imageView1.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [imageView1 setImage:image];
    
    [imageView1 setBackgroundColor:[UIColor redColor]];
    [self.articleScrollView addSubview:imageView1];
    //[imageView1 release];
    
    [self loadScrollViewWithPage:1];
    
     [self.view insertSubview:buttonView aboveSubview:articleScrollView];
     [buttonView addSubview:infobtu];
     [buttonView addSubview:mapbtu];
     [buttonView addSubview:framebtu];
     
     buttonView.hidden = YES;
     infobtu.hidden = YES;
     mapbtu.hidden = YES;
     framebtu.hidden = YES;
     
     top_titleView.frame = CGRectMake(0, 0, 1024, 38);
     [self.view insertSubview:top_titleView aboveSubview:articleScrollView];
     down_titleView.frame = CGRectMake(0, 748-38, 1024, 38);
     [self.view insertSubview:down_titleView aboveSubview:articleScrollView];
     
     //左侧文字结构图背景
     detailView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 37.0f, detailViewWidth, detailViewHeight)];
     detailView.userInteractionEnabled = YES;
     detailInfoView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 1.0f, detailViewWidth, detailViewHeight)];
     detailInfoView.backgroundColor = [UIColor blackColor];
     detailInfoView.userInteractionEnabled = YES;
     
     
     UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showItem:)];
     [singleTap setNumberOfTouchesRequired:1];
     [singleTap setNumberOfTapsRequired:1];
     singleTap.delegate = self;
     
     [self.view addGestureRecognizer:singleTap];
     [homebtn addTarget:self.parentViewController action:@selector(switchme) forControlEvents:UIControlEventTouchUpInside];
     
   

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
       
}

int showItems=0;
//modified by lingmengnj
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    NSLog(@"view tag is %d",touch.view.tag);
    //目录
    
   
    
    if (touch.view.tag ==1024||touch.view.tag ==1025||touch.view.tag ==1025) {
        
        if (([touch locationInView:self.view].y>50&&[touch locationInView:self.view].y<715)) {
            return YES;
        }
        return NO;
    }
    if (touch.view.tag ==11||touch.view.tag ==12||touch.view.tag ==13||touch.view.tag ==14||touch.view.tag ==15||touch.view.tag ==16||touch.view.tag ==17||touch.view.tag ==18||touch.view.tag ==19||touch.view.tag ==21||touch.view.tag ==200||touch.view.tag ==201||touch.view.tag ==202||touch.view.tag ==203 ||touch.view.tag ==230||touch.view.tag ==90||touch.view.tag ==91||touch.view.tag ==92||touch.view.tag ==93||touch.view.tag ==94||touch.view.tag ==95||touch.view.tag ==96 ||touch.view.tag ==1111111 ||touch.view.tag ==11110 ||touch.view.tag ==30000||touch.view.tag ==30001||touch.view.tag ==30002||touch.view.tag ==30003||touch.view.tag ==30004||touch.view.tag ==210||touch.view.tag ==211||touch.view.tag ==501||touch.view.tag ==502||touch.view.tag ==503||touch.view.tag ==504||touch.view.tag ==505||touch.view.tag ==506||touch.view.tag ==507||touch.view.tag ==212||touch.view.tag ==213||touch.view.tag ==214||touch.view.tag ==300||touch.view.tag ==301||touch.view.tag ==302||touch.view.tag ==303||touch.view.tag ==304||touch.view.tag ==305||touch.view.tag ==40000||touch.view.tag ==40001||touch.view.tag ==40002||touch.view.tag ==40003||touch.view.tag ==40004||touch.view.tag ==40005||touch.view.tag ==40006||touch.view.tag ==40007||touch.view.tag ==40008||touch.view.tag ==40009||touch.view.tag ==40010||touch.view.tag ==40011||touch.view.tag ==40012||touch.view.tag ==40013||touch.view.tag ==40014||touch.view.tag ==40015||touch.view.tag ==40016||touch.view.tag ==40017||touch.view.tag ==40018||touch.view.tag ==40019||touch.view.tag ==40020||touch.view.tag ==40021||touch.view.tag ==40022||touch.view.tag ==40023||touch.view.tag ==40024||touch.view.tag ==40025||touch.view.tag ==40026||touch.view.tag ==40027||touch.view.tag ==40028||touch.view.tag ==40029||touch.view.tag ==40030||touch.view.tag ==40031||touch.view.tag ==40032||touch.view.tag ==40033) {
        return NO;
    }
    if (showItems ==1 && touch.view.tag == 0 && [touch locationInView:self.view].y > 715) {
        return NO;
    }
    
    return YES;
}
//阅读页面的隐藏显示 
-(void)showItem:(UITouch *)touch{
    if (showItems==1) {
        if (listClicked) {
            listClicked = 0;
            [listbtu setImage:[UIImage imageNamed:@"1_1.png"] forState:UIControlStateNormal];
            [self hide];
        }
        if (shareClicked1) {
            shareClicked1 = 0;
            [talkbtu setImage:[UIImage imageNamed:@"5_5.png"] forState:UIControlStateNormal];
            [detailView removeFromSuperview];
        }
        if (shareClicked2) {
            shareClicked2 = 0;
            [wbbtu setImage:[UIImage imageNamed:@"6_6.png"] forState:UIControlStateNormal];
            [weiBoView removeFromSuperview];
            
        }
        top_titleView.hidden = YES;
        down_titleView.hidden = YES;
        showItems=0;
    }else if (showItems==0) {
        top_titleView.hidden = NO;
        down_titleView.hidden = NO;
        showItems=1; 
    }
    //  return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
//    self.wampsv.view =nil;
    self.articleScrollView = nil;
     self.weiBoView= nil;
     self.articleScrollView= nil;
     self.listsv= nil;
     self.top_titleView= nil;
     self.down_titleView= nil;
     self.myPageControl= nil;
     self.detailView= nil;
     self.detailInfoView= nil;
     self.buttonbackView= nil;
    self.listbtu= nil; 
    self.talkbtu= nil; 
    self.wbbtu= nil; 
    self.homebtn= nil; 
    self.infobtu= nil; self.mapbtu= nil;
    self.framebtu= nil; self.playbtu= nil; 
    self.leftbtu= nil; self.rightbtu= nil;
     //self.currentpage= nil;
     self.titlePageArray= nil;
     self.editeView= nil;
     self.editesv= nil;
     self.infoView= nil;
     self.infosv= nil;
     self.pagesSV= nil;
     self.mapVc= nil;
     self.moviepVc= nil;
     self.framesv= nil;
     self.buttonView= nil;
     self.viewControllers= nil;
     self.player= nil;
    self.listbtuname= nil; 
    self.mtalist= nil; 
    self.articleslist= nil; 
    self.pageslist= nil;
}
#pragma mark- hotpointmethods
/*infoClicked
 mapClicked
 frameClicked*/
int playbtushow = 0;
- (IBAction)MoviePlayCilcked:(id)sender
{ 
    //根据按钮的id判断播放哪种视频。此id必须所有杂志唯一 根据此热点id查找list
    
    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"02movie" ofType:@"mov"];
    //NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"cyborg" ofType:@"m4v"];
	self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:url]];
    //	[self.player play];
	
	// Create and configure AVPlayerLayer
	AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.timeOffset = 2.0f;
    playerLayer.beginTime = 2.0f;
    //playerLayer.repeatDuration = 0.20f;
	playerLayer.bounds = CGRectMake(710, 400, 280, 160);
	playerLayer.position = CGPointMake(850, 480);
	playerLayer.borderColor = [UIColor colorWithRed:109/255 green:109/255 blue:109/255 alpha:1.0].CGColor;
	playerLayer.borderWidth = 1.0;
//	playerLayer.shadowOffset = CGSizeMake(0, 3);
//	playerLayer.shadowOpacity = 0.80;
    playimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page5_sp"]] ;
    playimage.frame = CGRectMake(711, 401, 278, 158);
    
    // Add perspective transform
	//self.view.layer.sublayerTransform = CATransform3DMakePerspective(1000);	
	[titlebv.layer addSublayer:playerLayer];
    [titlebv addSubview:playimage];
    playbtu = [UIButton buttonWithType:UIButtonTypeCustom];
    playbtu.frame= CGRectMake(0, 0, 38, 37);
    playbtu.center = CGPointMake(850, 480);
    [titlebv addSubview:playbtu];
    [playbtu addTarget:self action:@selector(showmovie) forControlEvents:UIControlEventTouchUpInside];
    playbtu.tag = 212;
    [playbtu setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
}
-(void)showmovie{
    
    if (movie_play) {
        movie_play = 0;
        [self.player pause];
        
        [playbtu setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }else
    {
        [playbtu setImage:[UIImage imageNamed:@"hot_movie_pause2"] forState:UIControlStateNormal];
        movie_play = 1;
        [self.player play];
        [playimage removeFromSuperview];
    }
    //    [self playmovie];
    
}

//文本信息按纽事件
- (IBAction)InfobuttonCilcked:(id)sender
{
    top_titleView.hidden = YES;
    down_titleView.hidden = YES;
    if (movie_play) {
        movie_play = 0;
        [self.player pause];
    }
    if (infoClicked) {
        infoClicked = 0;
        [infobtu setImage:[UIImage imageNamed:@"4_4.png"] forState:UIControlStateNormal];
        titlebv.alpha = 0.8;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.8f];
        titlebv.alpha = 0;
        [UIView commitAnimations];

    }else
    {
        infoClicked = 1;
        
        if (frameClicked) {
            frameClicked = 0;

            framebv.alpha = 1;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            framebv.alpha = 0;
            [UIView commitAnimations];
            
            [framebtu setImage:[UIImage imageNamed:@"2_2.png"] forState:UIControlStateNormal];
        }
        
        [infobtu setImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
        if (titlebv!=nil||infoimage!=nil||moviepVc.view!=Nil||mapVc.view!=Nil) {
            [titlebv removeFromSuperview];
            titlebv = nil;
            [infoimage removeFromSuperview];
            infoimage =Nil;
            [moviepVc.view removeFromSuperview];
            moviepVc = nil;
            [mapVc.view removeFromSuperview];
            mapVc = nil;
        }
        [self letterInfo:currentpage];
        titlebv.alpha = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.8f];
        titlebv.alpha = 0.8;
        [UIView commitAnimations];
        //[titlebv release];
    }
}
//文本信息显示
- (void)letterInfo:(int)pages
{
    titlebv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    titlebv.backgroundColor = [UIColor whiteColor];
    titlebv.tag = 501;
    [self.view insertSubview:titlebv belowSubview:buttonView];
    infosv = [[BaseUIScrollView alloc] init];
    infosv.frame = titlebv.frame;
    infosv.tag = 506;
    NSString *infoImagName = [NSString stringWithFormat:@"%i_1wenzi.png",pages];
    UIImage * letterImage = [UIImage imageNamed:infoImagName];
    
    infosv.contentSize = CGSizeMake(0, letterImage.size.height);
    [titlebv addSubview:infosv];
    
    infoimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -2, letterImage.size.width, letterImage.size.height)];
    infoimage.tag = 502;
    
    [self MapbuttonCilcked:self];
    if (currentpage ==1) {
        [self MoviePlayCilcked:self];
    }
    
    
    infoimage.image = letterImage;
    [infosv addSubview:infoimage];
    //[infosv release];
   // [infoimage release];
}
///地图按纽事件
- (IBAction)MapbuttonCilcked:(id)sender
{
   NSMutableArray* latitude = [NSMutableArray arrayWithObjects:@"",@"58.99053",
                @"58.99053",
                @"58.346",
                @"31.1939",
                @"58.9705",
                @"58.9705",
                @"58.2988",
                @"60.39090",
                @"58.97381",
                @"58.9738",
                @"66.28",
                @"58.9738",
                @"58.9738",
                @"58.9738",
                @"58.9738",
                @"58.88904",
                @"58.9738",
                @"58.88180",
                @"58.9738",
                @"68.10034",
                @"59.06540",
                @"58.9738",
                @"58.9738",
                @"58.9738",
                @"58.9738",
                @"59.49929",
                @"58.97054",
                @"58.97054",
                @"46.5029",
                @"51.5005", nil];
  NSMutableArray*  longitude = [NSMutableArray arrayWithObjects:@"",@"6.13833",@"6.13833",@"7.809", @"121.4815",@"5.733",@"5.733", @"6.6599",@"5.3340",@"5.73469",@"5.735",@"12.3",
@"5.735",@"5.735",@"5.735",@"5.735",@"5.6529",@"5.735",
                 @"5.67111",
                 @"5.735",
                 @"16.3927",
                 @"5.9226",
                 @"5.735",
                 @"5.735",
                 @"5.735",
                 @"5.735",
                 @"6.5266",
                 @"5.73280",
                 @"5.73280",
                 @"11.358",
                 @"-0.1263",nil];
    top_titleView.hidden = YES;
    down_titleView.hidden = YES;
//    if (mapClicked) {
//        mapClicked = 0;
//        [mapbtu setImage:[UIImage imageNamed:@"3_3.png"] forState:UIControlStateNormal];
//        [mapVc.view removeFromSuperview];
//        infobtu.hidden = NO;
//        playbtu.hidden = NO;
//        [mapVc mapLoadView:currentpage latitude:[[latitude objectAtIndex:currentpage] floatValue]longitude:[[longitude objectAtIndex:currentpage]floatValue]];
//        if (frameClickedHidden) {
//            
//        }else
//        {
//            framebtu.hidden = NO;
//        }
//    }else
//    {
//        if (infoClicked) {
//            infoClicked = 0;
//            [infobtu setImage:[UIImage imageNamed:@"4_4.png"] forState:UIControlStateNormal];
//            //[titlebv removeFromSuperview];
//            //[infoimage removeFromSuperview];
//        }
//        if (frameClicked) {
//            frameClicked = 0;
//            [titlebv removeFromSuperview];
//            //[infoimage removeFromSuperview];
//            [framebtu setImage:[UIImage imageNamed:@"2_2.png"] forState:UIControlStateNormal];
//        }
        //infobtu.hidden = YES;
//       playbtu.hidden = YES;
//        framebtu.hidden = YES;
//        [mapVc addMapView:self];
        
//        [mapbtu setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
//        mapClicked = 1;
        mapVc = [[MapViewController alloc] init];
        mapVc.view .frame = CGRectMake(710, 180, 280, 180);
        
        [titlebv insertSubview:mapVc.view aboveSubview:infosv];
        //[self.view insertSubview:mapVc.view belowSubview:buttonView];
        [mapVc mapLoadView:currentpage latitude:[[latitude objectAtIndex:currentpage] floatValue]longitude:[[longitude objectAtIndex:currentpage]floatValue]];
        //[mapVc release];

       
//    }
}

//  结构按纽事件
- (IBAction)FramebuttonCilcked:(id)sender
{
    if (movie_play) {
        movie_play = 0;
        [self.player pause];
    }
    top_titleView.hidden = YES;
    down_titleView.hidden = YES;
    if (frameClicked) {
//        infobtu.hidden = NO;
//        mapbtu.hidden = NO;
//        playbtu.hidden = NO;
        frameClicked = 0;

        framebv.alpha = 1;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.8f];
        framebv.alpha = 0;
        [UIView commitAnimations];
        
        [framebtu setImage:[UIImage imageNamed:@"2_2.png"] forState:UIControlStateNormal];
        
    }else
    {
        if (infoClicked) {
            infoClicked = 0;
            [infobtu setImage:[UIImage imageNamed:@"4_4.png"] forState:UIControlStateNormal];
            [infobtu setImage:[UIImage imageNamed:@"4_4.png"] forState:UIControlStateNormal];
            titlebv.alpha = 0.8;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8f];
            titlebv.alpha = 0;
            [UIView commitAnimations];

        }
        if (framebv!=nil||framesv!=nil) {
            [framebv removeFromSuperview];
            framebv = nil;
            [framesv removeFromSuperview];
            framesv = nil;
        }

        switch (currentpage) {
            case 1:
                [self FrameInfo:currentpage totalPage:4];
                break;
            case 2:
                //[self FrameInfo:currentpage totalPage:5];
                break; 
            case 3:
                [self FrameInfo:currentpage totalPage:2];
                break;
            case 4:
                [self FrameInfo:currentpage totalPage:3];
                break;
            case 5:
                 [self FrameInfo:currentpage totalPage:1];
                break;
            case 6:
                //[self FrameInfo:currentpage totalPage:2];
                break;
            case 7:
                [self FrameInfo:currentpage totalPage:2];
                break;
            case 8:
                [self FrameInfo:currentpage totalPage:1];
                break;
            case 9:
                [self FrameInfo:currentpage totalPage:5];
                break;
            case 10:
                [self FrameInfo:currentpage totalPage:1];
                break;
            case 11:
               // [self FrameInfo:currentpage totalPage:4];
                break;
            case 12:
                [self FrameInfo:currentpage totalPage:2];
                break;
            case 13:
                [self FrameInfo:currentpage totalPage:2];
                break;
            case 14:
                [self FrameInfo:currentpage totalPage:2];
                break;
            case 15:
                [self FrameInfo:currentpage totalPage:2];
                break;
            case 16:
                [self FrameInfo:currentpage totalPage:10];
                break;
            case 17:
                [self FrameInfo:currentpage totalPage:1];
                break;
            case 18:
                [self FrameInfo:currentpage totalPage:9];
                break;           
            case 19:
                [self FrameInfo:currentpage totalPage:1];
                break;         
            case 20:
                [self FrameInfo:currentpage totalPage:5];
                break;       
            case 21:
             //   [self FrameInfo:currentpage totalPage:4];
                break;       
            case 22:
                [self FrameInfo:currentpage totalPage:1];
                break;       
            case 23:
                [self FrameInfo:currentpage totalPage:2];
                break;          
            case 24:
                [self FrameInfo:currentpage totalPage:1];
                break;       
            case 25:
                [self FrameInfo:currentpage totalPage:1];
                break;       
            case 26:
               // [self FrameInfo:currentpage totalPage:4];
                break;      
            case 27:
                [self FrameInfo:currentpage totalPage:3];
                break;      
            case 28:
                [self FrameInfo:currentpage totalPage:3];
                break;       
            case 29:
                [self FrameInfo:currentpage totalPage:1];
                break;       
            case 30:
                [self FrameInfo:currentpage totalPage:2];
                break;
            default:
                break;
        }
        framebv.alpha = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0f];
        framebv.alpha = 1;
        [UIView commitAnimations];
        [framebtu setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
        frameClicked = 1;
    }
}
- (void)removeFrameView
{
    if (framebv!=nil) {
        [framebv removeFromSuperview];
        framebv = nil;
    }
    if (framesv!=nil) {
        [framesv removeFromSuperview];
        framesv = nil;
    }
}
///结构图显示
- (void)FrameInfo:(int)pages totalPage:(int)tPage{
    framebv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    framebv.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:framebv belowSubview:buttonView];
    framebv.tag = 503;
    
    framesv = [[BaseUIScrollView alloc] init];
    framesv.backgroundColor = [UIColor blackColor];
    framesv.frame = CGRectMake(0, 0, 1024, 748);
//    framesv.scrollEnabled = NO;
    framesv.pagingEnabled = YES;
    framesv.showsHorizontalScrollIndicator = NO;
    framesv.showsVerticalScrollIndicator = NO;
    framesv.tag = 507;
    framesv.contentSize = CGSizeMake(1024, 748*tPage);
    [framebv addSubview:framesv];
    for (int i = 0; i<tPage; i++) {
        frameimage= [[UIImageView alloc] initWithFrame:CGRectMake(0, 748*i, 1024, 748)];
        NSString *infoImagName = [NSString stringWithFormat:@"%i_JG_%i.jpg",pages,i+1];
        
        frameimage.image = [UIImage imageNamed:infoImagName];
        frameimage.tag = 504;
        [framesv addSubview:frameimage];
        //[frameimage release];
    }
   
}
#pragma mark- toolbarmethods
//向前一页按纽事件
- (IBAction)forwardPage:(id)sender{
    if (currentpage>0) {
        [articleScrollView scrollRectToVisible:CGRectMake(1024*(currentpage-1),0,1024.0, 768.0) animated:YES];
        currentpage = currentpage -1;
        [listsv scrollRectToVisible:CGRectMake(532.0+(186*currentpage)-1024+93,0,1024.0, 160.0) animated:YES];
        listViewbtu.layer.borderWidth=1.0; 
        listViewbtu.layer.borderColor=[[UIColor greenColor] CGColor];
        [self removeLastContentWithIndex:currentpage+2];
        //[self listView:currentpage];
        [self loadScrollViewWithPage:currentpage];
        for (int i=0; i<kNumberOfArticle; i++) {
            [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:0.0F];
            [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
            if (currentpage== i) {
                [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:1.0F];
                [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
            }
        }
    }  
}
//向后一页按纽事件
- (IBAction)backwardPage:(id)sender{
    if (currentpage < kNumberOfArticle) {
        
        [articleScrollView scrollRectToVisible:CGRectMake(1024*(currentpage + 1),0,1024.0, 768.0) animated:YES];
        currentpage = currentpage +1 ;
        if (currentpage == kNumberOfArticle) {
            
        }else
        {
            [self loadScrollViewWithPage:currentpage];
            listsv.contentSize = CGSizeMake((186 * kNumberOfArticle + 66 +429), 160);
            [listsv scrollRectToVisible:CGRectMake(532.0+(186*currentpage)-1024+93,0,1024.0, 160.0) animated:YES];
            for (int i=0; i<kNumberOfArticle; i++) {
                [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:0.0F];
                [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
                if (currentpage== i) {
                    [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:1.0F];
                    [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
                }
            }
            listViewbtu.layer.borderWidth=1.0; 
            listViewbtu.layer.borderColor=[[UIColor greenColor] CGColor];
            [self removeLastContentWithIndex:currentpage-2];
        }
    }
}
/////// 获取当前面 currentpage
- (void) scrollViewDidScroll:(UIScrollView *)sender {
    //NSLog(@"09090909090");
    UIScrollView *scrollView = (UIScrollView *)sender;
    if (scrollView == articleScrollView) {
        CGFloat articleWidth = articleScrollView.frame.size.width;
        Articlecurrentpage = floor((sender.contentOffset.x - articleWidth/2)/articleWidth)+1;
        currentpage = Articlecurrentpage;
        if (Articlecurrentpage == 0) {
            leftbtu.hidden = YES;
            
        }else
        {
            leftbtu.hidden = NO;
        }
        
        if (Articlecurrentpage == kNumberOfArticle-1) {
            
            rightbtu.hidden = YES;
        }else
        {
            rightbtu.hidden = NO;
        }
        
        
        if (Articlecurrentpage>0) {
            buttonView.hidden = NO;
            infobtu.hidden = NO;
            //判断热点按钮
            if (Articlecurrentpage==2||Articlecurrentpage==6||Articlecurrentpage==11||Articlecurrentpage==21||Articlecurrentpage==26) {
                framebtu.hidden = YES;//scrollviewbt
                infobtu.frame = CGRectMake(126, 0, 38, 37);
                frameClickedHidden = 1;
            }else
            {
                infobtu.frame = CGRectMake(84, 0, 38, 37);
                framebtu.frame = CGRectMake(126, 0, 38, 37);
                frameClickedHidden = 0;
                framebtu.hidden = NO;
            }       
        }else
        {
            buttonView.hidden = YES;
            infobtu.hidden = YES;
            framebtu.hidden = YES;
        }
    }  


}

- (IBAction)Senderweibo:(id)sender{
    
}

- (IBAction)share:(id)sender{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
            break;
        case 12:
            if (shareClicked) {
                shareClicked = 0;
                [button setImage:[UIImage imageNamed:@"7_7.png"] forState:UIControlStateNormal];
            }else
            {
                shareClicked = 1;
                [button setImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
            }
            break;
        case 13:
            if (shareClicked1) {
                shareClicked1 = 0;
                [button setImage:[UIImage imageNamed:@"5_5.png"] forState:UIControlStateNormal];
                [detailView setFrame:CGRectMake(0, 37,  detailViewWidth1, detailViewHeight1)];
                [self.view insertSubview:detailView belowSubview:down_titleView];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.55f];
                [detailView setFrame:CGRectMake(0, 37,  detailViewWidth1, 0)];
                [UIView commitAnimations];
            }else
            {
                if (listClicked) {
                    listClicked = 0;
                    [listbtu setImage:[UIImage imageNamed:@"1_1.png"] forState:UIControlStateNormal];
                    [listsv removeFromSuperview];
                    listsv = nil;
                    [listViewbtu removeFromSuperview];
                    listViewbtu = nil;
                    [numberlab removeFromSuperview];
                    numberlab = nil;
                }
                if (shareClicked2) {
                    shareClicked2 = 0;
                    [wbbtu setImage:[UIImage imageNamed:@"6_6.png"] forState:UIControlStateNormal];
                    [weiBoView removeFromSuperview];
                    
                }
                shareClicked1 = 1;
                [button setImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
                [detailView setFrame:CGRectMake(0, 37,  detailViewWidth1, 0)];
                detailView.image = [UIImage imageNamed:@"评论.png"];
                [self.view insertSubview:detailView belowSubview:down_titleView];
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:0.25f];
                [detailView setFrame:CGRectMake(0, 37,  detailViewWidth1, detailViewHeight1)];
                [UIView commitAnimations];
            }
            break;
        case 14:
            
            if (shareClicked2) {
                shareClicked2 = 0;
                buttonView.hidden = NO;
                infobtu.hidden = NO;
                mapbtu.hidden = NO;
                framebtu.hidden = NO;
                [wbbtu setImage:[UIImage imageNamed:@"6_6.png"] forState:UIControlStateNormal];
                [weiBoView removeFromSuperview];
              
            }else
            {
                if (shareClicked1) {
                    shareClicked1 = 0;
                    [talkbtu setImage:[UIImage imageNamed:@"5_5.png"] forState:UIControlStateNormal];
                    [detailView removeFromSuperview];
                }
                if (listClicked) {
                    listClicked = 0;
                    [listbtu setImage:[UIImage imageNamed:@"1_1.png"] forState:UIControlStateNormal];
                    [detailView removeFromSuperview];
                    listsv = nil;
                    listViewbtu = nil;
                    numberlab = nil;
                }
                shareClicked2 = 1;
                buttonView.hidden = YES;
                infobtu.hidden = YES;
                mapbtu.hidden = YES;
                framebtu.hidden = YES;
                [wbbtu setImage:[UIImage imageNamed:@"6.png"] forState:UIControlStateNormal];
                weiBoView.center = CGPointMake(self.view.frame.size.width - wbViewWidth/2, 38+wbViewHeight/2);
                [self.view addSubview:weiBoView];
            }
            break;
        default:
            break;
    }
}
////
- (IBAction)Catalogbtu:(id)sender{
    if (listClicked) {
        listClicked = 0;
        [listbtu setImage:[UIImage imageNamed:@"1_1.png"] forState:UIControlStateNormal];
        [self hide];
    }else 
    {
        if (shareClicked1) {
            shareClicked1 = 0;
            [talkbtu setImage:[UIImage imageNamed:@"5_5.png"] forState:UIControlStateNormal];
            [weiBoView removeFromSuperview];    
        }
        if (shareClicked2) {
            shareClicked2 = 0;
            [wbbtu setImage:[UIImage imageNamed:@"6_6.png"] forState:UIControlStateNormal];
            [weiBoView removeFromSuperview];
            
        }
        listClicked = 1;
        [listbtu setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];

        [self listView:currentpage];
        [self showAnimation];
       
    }
}
//////显示小图片的列表smallpath
- (void)listView:(int)TempcurrentPage{
    if (listsv!=nil||detailInfoView!=nil) {
        [listsv removeFromSuperview];
        [detailInfoView removeFromSuperview];
        listsv = nil;
    }
    if (listsv==nil||detailInfoView==nil) {
        listsv = [[BaseUIScrollView alloc] init];
        listsv.frame = CGRectMake(0, 0, 1024, 177);
        listsv.contentSize = CGSizeMake((186 * kNumberOfArticle + 66), 177);
        listsv.backgroundColor = [UIColor clearColor];
        listsv.pagingEnabled = NO;
        listsv.showsHorizontalScrollIndicator = YES;
        listsv.showsVerticalScrollIndicator = NO;
        listsv.delegate = self;
        listsv.userInteractionEnabled = YES;  
        listsv.scrollEnabled = YES;
        listsv.canCancelContentTouches = YES;
        listsv.bounces = YES;
        listsv.delaysContentTouches = YES;
        listsv.directionalLockEnabled = YES;
        listsv.alwaysBounceVertical = NO;
        listbtuname = [[NSMutableArray alloc] init];
        for (int i = 0; i<[self.articleslist count]; i++) {
            Article *article=(Article *)[self.articleslist objectAtIndex:i];
            CGRect labFrame = CGRectMake(33+(166+20)*i, 5, 166, 20);
            CGRect imageFrame = CGRectMake(33+(166+20)*i, 30, 166, 126);
            CGRect labNumber = CGRectMake(33+(166+20)*i, 160, 166, 16);
            
            listViewbtu = [[UIButton alloc] initWithFrame:imageFrame];
            [self.listbtuname addObject:listViewbtu];
           // [listViewbtu release];
            [listViewbtu addTarget:self action:@selector(PageTranView:) forControlEvents:UIControlEventTouchUpInside];
            numberlab = [[UILabel alloc] initWithFrame:labFrame];
            
            
            UILabel *number = [[UILabel alloc] initWithFrame:labNumber];
            NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/BookContent/Book1/sjjzdb/134ch/small/"] stringByAppendingPathComponent:article.ContentBgImage]; 
            numberlab.text = article.Desc;   //[titleName objectAtIndex:i]; 
            
            UIImage *myImage = [UIImage imageWithContentsOfFile:path];
            
            numberlab.font = [UIFont systemFontOfSize:15];
            numberlab.backgroundColor = [UIColor clearColor];
            numberlab.textColor = [UIColor whiteColor];
            numberlab.textAlignment = UITextAlignmentLeft;
            
            number.backgroundColor = [UIColor clearColor];
            number.textColor = [UIColor whiteColor];
            number.text =[NSString stringWithFormat:@"%i",i+1]; 
            number.font = [UIFont systemFontOfSize:15];
            number.textAlignment = UITextAlignmentRight;
            
            [listViewbtu setImage:myImage forState:UIControlStateNormal];
            listViewbtu.tag = i+40000;
           
            listViewbtu.userInteractionEnabled = YES;
            if (TempcurrentPage ==i) {
                listViewbtu.layer.borderWidth=1.0; 
                listViewbtu.layer.borderColor=[[UIColor greenColor] CGColor];
            }
            [listsv addSubview:numberlab];
            [listsv addSubview:number];
            [listsv addSubview:listViewbtu];
          //  [number release];
           // [numberlab release];
        }
        [detailInfoView addSubview:listsv];
        //[listsv release];
    }

    
    if (currentpage<2) {
        [listsv scrollRectToVisible:CGRectMake(-512.0+(186*currentpage),0,1024.0, 160.0) animated:YES];  
    }
    if (currentpage>=2) {
        if (currentpage>=27) {
            listsv.contentSize = CGSizeMake((186 * kNumberOfArticle + 66 + 429), 160);
        }
        [listsv scrollRectToVisible:CGRectMake(532.0+(186*currentpage)-1024+93,0,1024.0, 160.0) animated:YES];
    }
}


//目录图片点击事件
int list_frame ;
//int  list_frame_show = 0;
- (void)PageTranView:(id)sender{

   
    UIButton *listViewbutton = (UIButton *)sender;
        NSLog(@"ÅÅÅÅÅÅÅ%i",listViewbutton.tag);

    for (int i=0; i<kNumberOfArticle; i++) {
        [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:0.0F];
        [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
        if (listViewbutton.tag == 40000 +i) {
            [articleScrollView scrollRectToVisible:CGRectMake(1024*i,0,1024.0, 768.0) animated:YES]; 
            [self loadScrollViewWithPage:i-1];
            [self loadScrollViewWithPage:i];
//            [self loadScrollViewWithPage:i+1];
            list_frame = i;
            listsv.contentSize = CGSizeMake((186 * kNumberOfArticle + 66 +429), 160);
            [listsv scrollRectToVisible:CGRectMake(532.0+(186*i)-1024+93,0,1024.0, 160.0) animated:YES];
            [[[self.listbtuname objectAtIndex:i] layer] setBorderWidth:1.0F];
            [[[self.listbtuname objectAtIndex:i] layer] setBorderColor:[[UIColor greenColor] CGColor]];
        }else 
        {
            if (i==list_frame + 1||i==list_frame - 1||i==list_frame) {
                
            }else
            {
                 [self removeLastContentWithIndex:i];
            }
            
           
        }  
    }
     
}

-(void)showAnimation{
    detailView.image = [UIImage imageNamed:@"backGroundView.png"];
    [detailView setFrame:CGRectMake(0, 748,  detailViewWidth, detailViewHeight)];
	[self.view insertSubview:buttonView belowSubview:detailView];
    [self.view insertSubview:detailView belowSubview:down_titleView];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25f];
    [detailView setFrame:CGRectMake(0, 528,  detailViewWidth, detailViewHeight)];
	[UIView commitAnimations];
    
    [detailInfoView setFrame:CGRectMake(0.0f, 0,1024.0f, 220.0f)]; 
    detailInfoView.alpha = 0;
	[detailView addSubview:self.detailInfoView];
    //    [self.detailInfoView addSubview:listsv];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25f];
	detailInfoView.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)hide{
    
    detailInfoView.alpha = 1.0;
    //    [self.view addSubview:self.detailInfoView];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.55f];
    detailInfoView.alpha = 0;
	[UIView commitAnimations];
    
    
    [self.view insertSubview:buttonView belowSubview:detailView];
    [detailView setFrame:CGRectMake(0, 528,  detailViewWidth, detailViewHeight)];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50f]; 
	[detailView setFrame:CGRectMake(0, 748,  detailViewWidth, detailViewHeight)];
	[UIView commitAnimations];

    
}

- (void)Hidden_showView
{
   
    [listsv removeFromSuperview];
    listsv = nil;
    listViewbtu = nil;
    numberlab = nil;
}

@end
