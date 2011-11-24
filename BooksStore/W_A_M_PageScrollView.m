//
//  W_A_M_PageScrollView.m
//  World_Architect_Magazine
//
//  Created by fei chen on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "W_A_M_PageScrollView.h"

@implementation W_A_M_PageScrollView

@synthesize backsv;

@synthesize wamhomevc;
@synthesize myPageControl;
@synthesize imageView;
@synthesize titleSv;

@synthesize lettervc;
@synthesize framevc;
@synthesize mapvc;
@synthesize listvc;

NSInteger currentpage ;
NSInteger kNumberOfPages ;

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
#define button_Width 37
#define button_Height 36
#define letter_button_top 58
#define letter_button_left 968
#define map_button_top 660
#define map_button_left 38

#define fram_letter_button_top 68
#define fram_letter_button_left 360

#define fram_top 521
#define fram_left 1

#define fram_Width 552
#define fram_Height 226

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 1024, 748);
    // Do any additional setup after loading the view from its nib.
    
    kNumberOfPages = 5;
    
    backsv.frame = CGRectMake(0, 0, 1024, 748);
    
    backsv.contentSize = CGSizeMake(0,748 * kNumberOfPages);
    backsv.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    backsv.pagingEnabled = YES;
    backsv.showsHorizontalScrollIndicator = NO;
    backsv.showsVerticalScrollIndicator = NO;
    backsv.delegate = self;
    backsv.userInteractionEnabled = YES;  
    backsv.scrollEnabled = YES;
    backsv.canCancelContentTouches = YES;
    backsv.bounces = YES;
    backsv.delaysContentTouches = NO;
    backsv.directionalLockEnabled = YES;
    backsv.alwaysBounceVertical = YES;
    [self.view insertSubview:self.backsv belowSubview:self.myPageControl];
    for (int i = 0; i<kNumberOfPages; i++) {
        
        //NSString *imageName = [NSString stringWithFormat:@"page%d.png",i+1];
       NSMutableArray *titlePageArray = [[NSMutableArray alloc] initWithObjects:@"page1.png",@"page2.png",@"page3.png",@"page4.png",@"page5.png", nil];
        

        UIImage *image = [UIImage imageNamed:[titlePageArray objectAtIndex:i]];
        NSLog(@"????????????%@",wamhomevc.titlePageArray);
        CGRect viewFrame = CGRectMake(0, 748*i, 1024, 748);
        imageView = [[UIImageView alloc] initWithFrame:viewFrame];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        [self.backsv addSubview:imageView]; 
        if (i==0) {
            //增加地图、图片切换动画 
            mapvc = [[MapViewController alloc] init];
            mapvc.view.frame = CGRectMake(0, 148, 1024, 600);
            [self.backsv insertSubview:mapvc.view aboveSubview:imageView];
            UIButton *letterBtu = [UIButton buttonWithType:UIButtonTypeCustom];
            letterBtu.frame = CGRectMake(letter_button_left, letter_button_top, button_Width, button_Height);
            [letterBtu setImage:[UIImage imageNamed:@"btn-wenzidakai.png"] forState:UIControlStateNormal];
            [letterBtu addTarget:self action:@selector(addLetterView:) forControlEvents:UIControlEventTouchUpInside];
            [letterBtu setTag:200];
            [imageView addSubview:letterBtu];

        }
        if (i==4) {
            //增加结构文字层
            UIButton *framebtu = [UIButton buttonWithType:UIButtonTypeCustom];
            framebtu.frame = CGRectMake(fram_letter_button_left, fram_letter_button_top, button_Width, button_Height);
            [framebtu setImage:[UIImage imageNamed:@"btn-wenzidakai.png"] forState:UIControlStateNormal];
            [framebtu addTarget:self action:@selector(addFrameView:) forControlEvents:UIControlEventTouchUpInside];
            [framebtu setTag:210];
            [imageView addSubview:framebtu];
            
            UIViewController *frameView = [[FrameViewController alloc] init ];
            //frameView.view.backgroundColor = [UIColor redColor];
            frameView.view.frame = CGRectMake(fram_left,fram_top,fram_Width,fram_Height);
            [imageView addSubview:frameView.view];
            
        }
        
        
        
    }
    
  
    
    
   
   
    [self PageControl:kNumberOfPages];
    //[self showButtons];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void) scrollViewDidScroll:(UIScrollView *)sender 
{
    CGFloat pageHight = backsv.frame.size.height;
    
    
    currentpage = floor((backsv.contentOffset.y - pageHight / 2) / pageHight) + 1;
    self.myPageControl.currentPage = currentpage;

   
        

    
}
-(void)changePage:(id)sender{
    
//	int page = self.myPageControl.currentPage;
//    
//	CGRect frame = [self.view bounds];
//	frame.origin.x = frame.size.width*page;
//	frame.origin.y = 0;
//	[backsv scrollRectToVisible:frame animated:YES];
	
}

#define PageViewWidth  6.0
#define PageViewHeight 6.0

#define PageViewYGap   6.0
#define PageViewToTopLeft 1005
#define PageViewToTopDown 12


- (void)PageControl:(NSInteger)kNumberOfPages 
{
    if (kNumberOfPages == 0) {
        
    }
    // NSLog(@"tell me what");
    UIPageControl *pageControll = [[[UIPageControl alloc] initWithFrame:CGRectMake(PageViewToTopLeft, ((PageViewHeight+PageViewHeight)*kNumberOfPages-PageViewHeight), 748, PageViewWidth)] autorelease];
	self.myPageControl = pageControll;
    //self.myPageControl.backgroundColor = [UIColor blackColor];
	//[self.myPageControl setBounds:CGRectMake(0, 0, 5 * (kNumberOfPages - 1) + 5, 16)];
	self.myPageControl.center = CGPointMake(PageViewToTopLeft+PageViewWidth/2, self.view.frame.size.height-((PageViewHeight/2+PageViewHeight)*kNumberOfPages+PageViewToTopDown));
	self.myPageControl.numberOfPages = kNumberOfPages;
	[self.myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    myPageControl.transform = transform;
    
	[self.view insertSubview:self.myPageControl aboveSubview:self.backsv];
    
}


////.....



//////.......
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {	
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
    }
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
        backsv.frame = CGRectMake(0, 0, 1024, 748);


        
    }
    
    
}

///增加文字层
- (void)addLetterView:(id)sender
{
    titlebv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    titlebv.backgroundColor = [UIColor whiteColor];//initWithPatternImage:[UIImage imageNamed:@"baidi.png"]];
    
    [self.view addSubview:titlebv];
    [titlebv release];
    UIButton *letterBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    letterBtu.frame = CGRectMake(letter_button_left, letter_button_top, button_Width, button_Height);
    [letterBtu setImage:[UIImage imageNamed:@"btn-wenzi.png"] forState:UIControlStateNormal];
    [letterBtu addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [letterBtu setTag:202];
    [titlebv addSubview:letterBtu];
    lettervc = [[LetterViewController alloc] init];
    lettervc.view.frame = CGRectMake(0, 0, 1024, 748);
    [titlebv insertSubview:lettervc.view belowSubview:letterBtu];

    titlebv.alpha = 0;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.25f];
	titlebv.alpha = 0.8;
	[UIView commitAnimations];
 

}
- (void)close
{
    titlebv.alpha = 0.8;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.25f];
	titlebv.alpha = 0;
	[UIView commitAnimations];
    
}
- (void)addFrameView:(id)sender
{

    frameColsebtu = [UIButton buttonWithType:UIButtonTypeCustom];
    frameColsebtu.frame = CGRectMake(fram_letter_button_left, fram_letter_button_top, button_Width, button_Height);
    [frameColsebtu setImage:[UIImage imageNamed:@"btn-wenzi.png"] forState:UIControlStateNormal];
    [frameColsebtu addTarget:self action:@selector(closeframe) forControlEvents:UIControlEventTouchUpInside];
    [frameColsebtu setTag:211];
    [self.view addSubview:frameColsebtu];
    letterbv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 345, 195)];
    letterbv.backgroundColor = [[UIColor clearColor] initWithPatternImage:[UIImage imageNamed:@"heidi.png"]];
    letterbv.center =  CGPointMake(frameColsebtu.center.x-345/2, frameColsebtu.center.y+195/2);
    [self.view insertSubview:letterbv belowSubview:frameColsebtu];
    
    letterbv.alpha = 0;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.25f];
	letterbv.alpha = 1.0;
	[UIView commitAnimations];
    [letterbv release];
}
- (void)closeframe
{
    [frameColsebtu removeFromSuperview];
    letterbv.alpha = 1.0;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.25f];
	letterbv.alpha = 0;
	[UIView commitAnimations];
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}




@end
