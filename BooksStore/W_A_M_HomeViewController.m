//
//  W_A_M_HomeViewController.m
//  World_Architect_Magazine
//
//  Created by fei chen on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "W_A_M_HomeViewController.h"
#import "FirstViewController.h"

@implementation W_A_M_HomeViewController



@synthesize wampsv;
@synthesize weiBoView;
@synthesize articleScrollView;
@synthesize listsv;
//@synthesize titleView;
@synthesize top_titleView;
@synthesize down_titleView;
@synthesize lettervc;
@synthesize framevc;
@synthesize mapvc;
@synthesize listvc;
@synthesize detailView;
@synthesize detailInfoView;
@synthesize buttonbackView;
@synthesize listbtu,talkbtu,wbbtu,homebtn;
@synthesize currentpage;
@synthesize titlePageArray;
NSInteger Articlecurrentpage ;
NSInteger ArticleOfPages = 4;


NSInteger kNumberOfPages ;

BOOL letter_hidden = 0 ;
BOOL map_hidden = 0;
BOOL frame_hidden = 0;
BOOL list_hidden = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{

    
    [super viewWillAppear:animated];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  NSLog(@"----%d",[[self.tabBarController viewControllers]count]);
    
    articleScrollView.frame = CGRectMake(0, 0, 1024, 748);
    articleScrollView.contentSize = CGSizeMake(1024* ArticleOfPages,748 );
    articleScrollView.backgroundColor = [UIColor viewFlipsideBackgroundColor];
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
    [self.view addSubview:articleScrollView];
    
    for (int i = 0; i<ArticleOfPages; i++) {
        NSArray *imageName = [NSArray arrayWithObjects:@"00_1_bg.png",@"image1.png",@"文章004_1.jpg",@"02_1_bg.png", nil];
       
        
        UIImage *image = [UIImage imageNamed:[imageName objectAtIndex:i]];
        CGRect viewFrame = CGRectMake(1024*i, 0, 1024, 748);
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:viewFrame];
        imageView1.image = image;
        imageView1.userInteractionEnabled = YES;
        imageView1.tag = i;
        
       
        
        [self.articleScrollView addSubview:imageView1];
        [imageView1 release];
    }
    
    top_titleView.frame = CGRectMake(0, 0, 1024, 38);
    [self.view insertSubview:top_titleView aboveSubview:articleScrollView];
    down_titleView.frame = CGRectMake(0, 748-38, 1024, 38);
    [self.view insertSubview:down_titleView aboveSubview:articleScrollView];
    
    wampsv = [[W_A_M_PageScrollView alloc] init];
    wampsv.view.frame = CGRectMake(0, 0, 1024, 748);
    wampsv.view.tag=9999;//特殊判断
    
    [wampsv setWamhomevc:self];
    
    kNumberOfPages = 0;
    if (kNumberOfPages == 0) {
       
    }else
    {
        [self.view insertSubview:self.wampsv.view aboveSubview:self.articleScrollView];
    }

    //左侧文字结构图背景
    detailView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 37.0f, detailViewWidth, detailViewHeight)];
    detailView.userInteractionEnabled = YES;
    detailInfoView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 1.0f, detailViewWidth, detailViewHeight)];
    detailInfoView.backgroundColor = [UIColor clearColor];
    detailInfoView.userInteractionEnabled = YES;
    

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showItem:)];
    [singleTap setNumberOfTouchesRequired:1];
    [singleTap setNumberOfTapsRequired:1];
    singleTap.delegate = self;

    [self.view addGestureRecognizer:singleTap];
    
    //[homebtn 
     [homebtn addTarget:self.parentViewController action:@selector(switchme) forControlEvents:UIControlEventTouchUpInside];
}

int showItems=0;
//modified by lingmengnj
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    NSLog(@"view tag is %d",touch.view.tag);
    //目录
    for (int i=0; i<3; i++) {
        if (touch.view.tag == 40000 +i) {
            [articleScrollView scrollRectToVisible:CGRectMake(1024*i,0,1024.0, 768.0) animated:YES];
            [self listView];
        }
    }
    
   
    
    if (touch.view.tag ==1024||touch.view.tag ==1025||touch.view.tag ==1025) {
        
        if (([touch locationInView:self.view].y>50&&[touch locationInView:self.view].y<715)) {
            return YES;
        }
        return NO;
    }
    if (touch.view.tag ==11||touch.view.tag ==12||touch.view.tag ==13||touch.view.tag ==14||touch.view.tag ==15||touch.view.tag ==16||touch.view.tag ==17||touch.view.tag ==18||touch.view.tag ==19||touch.view.tag ==20||touch.view.tag ==21||touch.view.tag ==22||touch.view.tag ==200||touch.view.tag ==201||touch.view.tag ==202||touch.view.tag ==203 ||touch.view.tag ==230
        ||touch.view.tag ==210||touch.view.tag ==211||touch.view.tag ==300||touch.view.tag ==301||touch.view.tag ==302||touch.view.tag ==303||touch.view.tag ==304||touch.view.tag ==305||touch.view.tag ==40000||touch.view.tag ==40001||touch.view.tag ==40002) {
        return NO;
    }
    if (showItems ==1 && touch.view.tag == 0 && [touch locationInView:self.view].y > 715) {
        return NO;
    }
    
    return YES;
}

-(void)showItem:(UITouch *)touch{
    if (showItems==1) {
        if (listClicked) {
            listClicked = 0;
            [listbtu setImage:[UIImage imageNamed:@"1_1.png"] forState:UIControlStateNormal];
            [self hideInfo];
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
    self.wampsv.view =nil;
    self.articleScrollView = nil;
    self.homebtn=nil;
}

//向前一页按纽事件
- (IBAction)forwardPage:(id)sender
{
    if (currentpage>0) {
        [articleScrollView scrollRectToVisible:CGRectMake(1024*(currentpage-1),0,1024.0, 768.0) animated:YES];
        currentpage = currentpage;
        [self listView];
    }
    
}
//向后一页按纽事件
- (IBAction)backwardPage:(id)sender
{
    if (currentpage < ArticleOfPages) {
        
        [articleScrollView scrollRectToVisible:CGRectMake(1024*(currentpage + 1),0,1024.0, 768.0) animated:YES];
        currentpage = currentpage ;
        [self listView];
    }
    
}


/////// 获取当前面 currentpage
- (void) scrollViewDidScroll:(UIScrollView *)sender 
{
    
    CGFloat articleWidth = articleScrollView.frame.size.width;
    Articlecurrentpage = floor((sender.contentOffset.x - articleWidth/2)/articleWidth)+1;
    currentpage = Articlecurrentpage;
    if (Articlecurrentpage == 0) {
//        [titleView removeFromSuperview];
//        titleView.hidden = YES;
        
        
    }
    if (Articlecurrentpage == 1 ) {
        //纵向的有问题，需要调试
        self.wampsv.view.frame = CGRectMake(1024*Articlecurrentpage,0,1024.0, 748.0);
        self.articleScrollView.tag=9991;
        
        [self.articleScrollView addSubview:self.wampsv.view ];
        titlePageArray = [[NSMutableArray alloc] initWithObjects:@"page1.png",@"page2.png",@"page3.png",@"page4.png",@"page5.png", nil];
        //NSLog(@"????????????%@",titlePageArray);
    
    }
    if (Articlecurrentpage == 2 ) {
        self.wampsv.view.frame = CGRectMake(1024*Articlecurrentpage,0,1024.0, 748.0);
        self.articleScrollView.tag=9991;
        [self.articleScrollView addSubview:self.wampsv.view ];
        titlePageArray = [[NSMutableArray alloc] initWithObjects:@"文章004_1.jpg",@"文章004_2.jpg",@"文章004_3.png",@"文章004_4.jpg",@"文章004_1.png", nil];
    }
    for (int i = 1; i<100; i++) {
        if ((int)sender.contentOffset.x/i == 1024) {
//            if ((sender.contentOffset.x - articleWidth*i)>articleWidth/2  ) {
//                 NSLog(@"Why why why why why!!!!!!!");
//                Articlecurrentpage = floor((sender.contentOffset.x - articleWidth/2)/articleWidth)+1;
//                currentpage = Articlecurrentpage;
//            }else if((articleWidth*i -sender.contentOffset.x )>articleWidth/2 )
//            {
                
                Articlecurrentpage = floor((sender.contentOffset.x - articleWidth/2)/articleWidth)+1;
                currentpage = Articlecurrentpage;
            //[self Auto_Hidden_Title_Show_Animation];
           
//            if (Articlecurrentpage == 0) {
//                [titleView removeFromSuperview];
//                titleView.hidden = YES;
//                
//                
//            }
//            if (Articlecurrentpage == 1 ) {
//                //纵向的有问题，需要调试
//                self.wampsv.view.frame = CGRectMake(1024*Articlecurrentpage,0,1024.0, 748.0);
//                //[self.view insertSubview:self.wampsv.view  belowSubview:titleView];
//                self.articleScrollView.tag=9991;
//                //self.articleScrollView.frame=wampsv
//              
//                [self.articleScrollView insertSubview:self.wampsv.view aboveSubview:titleView];
//              
//                //标题view
//                titleView.hidden = NO;
//                titleView.frame = CGRectMake(0, 0, 1024, 38);
//                [self.view insertSubview:titleView aboveSubview:self.articleScrollView];
//                
//                // [self Auto_Hidden_Title_Hidden_Animation];
//            }
//            }else
//            {
//                
//            }

//            NSLog(@"Why why why why why");
        }else
        {
           // currentpage = 0;
        }
       
    }
    //Articlecurrentpage = floor((sender.contentOffset.x - articleWidth/2)/articleWidth)+1;
//    NSLog(@"%f",sender.contentOffset.x);
//    NSLog(@"Articlecurrentpage%d",Articlecurrentpage);
    
   
   
}


    //////.......
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {	
   
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
       
    }
    
     if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        articleScrollView.frame = CGRectMake(0, 0, 1024, 748);
        wampsv.view.frame = CGRectMake(0, 0, 1024, 748);
    
    } 
}

- (IBAction)Senderweibo:(id)sender
{
    
}

- (IBAction)share:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 11: 
            //[self tabBarController:self.tabBarController didSelectViewController:nil];
            NSLog(@"dsdsds");
            //[self.tabBarController 
           
            
             //[self.tabBarController setSelectedIndex:0]; 
            //Home 按纽事件
//            UIViewController *homevc = [[FirstViewController alloc] init];
//            self.tabBarController.tabBar.hidden = NO;
//            [self.view addSubview:homevc.view];
//            [homevc release];
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
                    listsv = nil;
                    imageView = nil;
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
//                UIImageView *talk =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评论.png"]];
//                talk.frame =CGRectMake(0, 37,  detailViewWidth1, detailViewHeight1);
//                [detailView addSubview:talk];
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
                    imageView = nil;
                    numberlab = nil;
                }
                shareClicked2 = 1;
                [wbbtu setImage:[UIImage imageNamed:@"6.png"] forState:UIControlStateNormal];
                weiBoView.center = CGPointMake(self.view.frame.size.width - wbViewWidth/2, 38+wbViewHeight/2);
                [self.view addSubview:weiBoView];
            }
            break;
        default:
            break;
    }
}

- (IBAction)Catalogbtu:(id)sender
{
    if (listClicked) {
        listClicked = 0;
        [listbtu setImage:[UIImage imageNamed:@"1_1.png"] forState:UIControlStateNormal];
        [self hideInfo];
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
//        currentpage = Articlecurrentpage;
//        listsv = [[BaseUIScrollView alloc] init];
//        listsv.frame = CGRectMake(0, 0, 1024, 160);
//        listsv.contentSize = CGSizeMake(222 * 30 + 120, 160);
//        listsv.backgroundColor = [UIColor clearColor];
//        listsv.pagingEnabled = NO;
//        listsv.showsHorizontalScrollIndicator = NO;
//        listsv.showsVerticalScrollIndicator = NO;
//        listsv.delegate = self;
//        listsv.userInteractionEnabled = YES;  
//        listsv.scrollEnabled = YES;
//        listsv.canCancelContentTouches = YES;
//        listsv.bounces = YES;
//        listsv.delaysContentTouches = NO;
//        listsv.directionalLockEnabled = YES;
//        listsv.alwaysBounceVertical = NO;
//        
//        for (int i = 0; i<ArticleOfPages; i++) {
//            NSArray *imageName = [NSArray arrayWithObjects:@"00_1_bg.png",@"image1.png",@"02_1_bg.png", nil];
//            NSArray *titleName = [NSArray arrayWithObjects:@"世界建筑导报",@"罗马荷兰大使馆改造",@"办公楼", nil];
//            
//            CGRect imageFrame = CGRectMake(0, 0, 166, 126);
//            CGRect labFrame = CGRectMake(0, 0, 166, 16);
//            
//            imageView = [[UIImageView alloc] initWithFrame:imageFrame];
//            numberlab = [[UILabel alloc] initWithFrame:labFrame];
//            UIImage *image = [UIImage imageNamed:[imageName objectAtIndex:i]];
//            numberlab.text = [titleName objectAtIndex:i]; 
//            
//            if (currentpage == i) {
//                NSLog(@"currentpage%i",currentpage);
//                imageView.center = CGPointMake(512, 10+125/2);
//                numberlab.center = CGPointMake(512, 140+15/2);
//                
//            }else
//            {
//                if (currentpage>0) {
//                    if (i<currentpage) {
//                        {
//                            imageView.center = CGPointMake(512-(166+20)*(currentpage - i), 10+126/2);
//                            numberlab.center = CGPointMake(512-(166+20)*(currentpage - i), 140+16/2);
//                            imageView.alpha = 0.8;
//                            NSLog(@"currentpage min%i",i);
//                        }
//                    }else
//                        if (i>currentpage) {  
//                            imageView.center = CGPointMake(512+(166+20)*(i-currentpage), 10+126/2);
//                            numberlab.center = CGPointMake(512+(166+20)*(i-currentpage), 140+16/2);
//                            imageView.alpha = 0.8;
//                            NSLog(@"currentpage max%i",i);
//                        }   
//                }
//                if (currentpage == 0) {
//                    
//                    imageView.center = CGPointMake(512+(165+20)*i, 10+125/2);
//                    numberlab.center = CGPointMake(512+(165+20)*i, 140+15/2);
//                    imageView.alpha = 0.8;
//                    NSLog(@"currentpage max%i",i);
//                }    
//            }
//            imageView.image = image;
//            imageView.tag = i+40000;
//            numberlab.backgroundColor = [UIColor clearColor];
//            numberlab.textColor = [UIColor whiteColor];
//            numberlab.textAlignment = UITextAlignmentLeft;
//            imageView.userInteractionEnabled = YES;
//            
//            [self.listsv addSubview:numberlab];
//            [self.listsv addSubview:imageView];
//            [imageView release];
//            [numberlab release];
//        }
//        [detailView addSubview:listsv];
//       [self showAnimation];
////        [self loadView];
        [self listView];
        [self showAnimation];
       
    }
}

- (void)listView
{
    if (listsv!=nil) {
        [listsv removeFromSuperview];
        listsv = nil;
    }
    currentpage = Articlecurrentpage;
    listsv = [[BaseUIScrollView alloc] init];
    listsv.frame = CGRectMake(0, 20, 1024, 160);
    listsv.contentSize = CGSizeMake(222 * 30 + 120, 160);
    listsv.backgroundColor = [UIColor clearColor];
    listsv.pagingEnabled = NO;
    listsv.showsHorizontalScrollIndicator = NO;
    listsv.showsVerticalScrollIndicator = NO;
    listsv.delegate = self;
    listsv.userInteractionEnabled = YES;  
    listsv.scrollEnabled = YES;
    listsv.canCancelContentTouches = YES;
    listsv.bounces = YES;
    listsv.delaysContentTouches = YES;
    listsv.directionalLockEnabled = YES;
    listsv.alwaysBounceVertical = NO;
    
    for (int i = 0; i<ArticleOfPages; i++) {
        NSArray *imageName = [NSArray arrayWithObjects:@"00_1_bg.png",@"image1.png",@"文章004_1.jpg",@"02_1_bg.png", nil];
        NSArray *titleName = [NSArray arrayWithObjects:@"世界建筑导报",@"罗马荷兰大使馆改造",@"生物技术实验公司",@"办公楼", nil];
        
        CGRect imageFrame = CGRectMake(0, 0, 166, 126);
        CGRect labFrame = CGRectMake(0, 0, 166, 16);
        
        imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        numberlab = [[UILabel alloc] initWithFrame:labFrame];
        UIImage *image = [UIImage imageNamed:[imageName objectAtIndex:i]];
        numberlab.text = [titleName objectAtIndex:i]; 
        
        if (currentpage == i) {
            NSLog(@"currentpage%i",currentpage);
            imageView.center = CGPointMake(512, 10+125/2);
            numberlab.center = CGPointMake(512, 140+15/2);
            
        }else
        {
            if (currentpage>0) {
                if (i<currentpage) {
                    {
                        imageView.center = CGPointMake(512-(166+20)*(currentpage - i), 10+126/2);
                        numberlab.center = CGPointMake(512-(166+20)*(currentpage - i), 140+16/2);
                        imageView.alpha = 0.8;
                        NSLog(@"currentpage min%i",i);
                    }
                }else
                    if (i>currentpage) {  
                        imageView.center = CGPointMake(512+(166+20)*(i-currentpage), 10+126/2);
                        numberlab.center = CGPointMake(512+(166+20)*(i-currentpage), 140+16/2);
                        imageView.alpha = 0.8;
                        NSLog(@"currentpage max%i",i);
                    }   
            }
            if (currentpage == 0) {
                
                imageView.center = CGPointMake(512+(165+20)*i, 10+125/2);
                numberlab.center = CGPointMake(512+(165+20)*i, 140+15/2);
                imageView.alpha = 0.8;
                NSLog(@"currentpage max%i",i);
            }    
        }
        imageView.image = image;
        imageView.tag = i+40000;
        numberlab.backgroundColor = [UIColor clearColor];
        numberlab.textColor = [UIColor whiteColor];
        numberlab.textAlignment = UITextAlignmentLeft;
        imageView.userInteractionEnabled = YES;
        
        [self.listsv addSubview:numberlab];
        [self.listsv addSubview:imageView];
        [imageView release];
        [numberlab release];
    }
    [detailView addSubview:listsv];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)barController didSelectViewController:(UIViewController *)viewController{  
    
    NSLog(@"currentController index:%d",self.tabBarController.selectedIndex);  
    UIViewController  *currentController =self.tabBarController.selectedViewController;  
    NSLog(@"currentController: %@",currentController);  
    self.tabBarController.selectedIndex = 0; 
} 


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touch touch touch touch ??????????????????????");

}


//顶部标题栏显示 动画； 
- (void)Auto_Hidden_Title_Show_Animation
{
    

//    titleView.frame = CGRectMake(0, 0, 1024, 38);
//    [self.view insertSubview:titleView aboveSubview:self.articleScrollView];
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.25f];
//    [animation setTimingFunction:[CAMediaTimingFunction
//                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromBottom];
//    [titleView.layer addAnimation:animation forKey:@"Push"];
//    if (animation_hidden) {
//        
//    }else
//    {
//        NSTimer *auto_hidden;
//        auto_hidden = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(Auto_Hidden_Title_Hidden_Animation) userInfo:nil repeats:NO];
//    }
//   
 
}

- (void)Auto_Hidden_Title_Hidden_Animation
{
//    titleView.frame = CGRectMake(0, 0, 1024, -138);
//    [self.view insertSubview:titleView aboveSubview:self.articleScrollView];
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.50f];
//    [animation setTimingFunction:[CAMediaTimingFunction
//                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromTop];
//    [titleView.layer addAnimation:animation forKey:@"Push"];
}


-(void)showAnimation{
    detailView.image = [UIImage imageNamed:@"文字背景层.png"];
    [detailView setFrame:CGRectMake(0, 748,  detailViewWidth, detailViewHeight)];
	[self.view insertSubview:detailView belowSubview:down_titleView];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25f];
    [detailView setFrame:CGRectMake(0, 528,  detailViewWidth, detailViewHeight)];
	[UIView commitAnimations];
    [self showInfoAnimation];
}

- (void)hide{
    
    [detailView setFrame:CGRectMake(0, 528,  detailViewWidth, detailViewHeight)];
//    [self.view addSubview:self.detailView];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.50f]; 
	[detailView setFrame:CGRectMake(0, 748,  detailViewWidth, detailViewHeight)];
	[UIView commitAnimations];
    
    NSTimer *hidden;
    hidden = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(Hidden_showView) userInfo:NO repeats:NO];
    
}

- (void)Hidden_showView
{
    
    [listsv removeFromSuperview];
    listsv = nil;
    imageView = nil;
    numberlab = nil;
}

- (void)showInfoAnimation{
    
    [detailInfoView setFrame:CGRectMake(0.0f, 0,1024.0f, 220.0f)]; 
    detailInfoView.alpha = 0;
	[detailView addSubview:self.detailInfoView];
    [self.detailInfoView addSubview:listsv ];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.25f];
	detailInfoView.alpha = 1.0;
	[UIView commitAnimations];
}

- (void)hideInfo{
    
    detailInfoView.alpha = 1.0;
//    [self.view addSubview:self.detailInfoView];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.55f];
    detailInfoView.alpha = 0;
	[UIView commitAnimations];
    

    [self hide];
}

- (void)hiddenView
{
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}


@end
