//
//  FrameViewController.m
//  World_Architect_Magazine
//
//  Created by ZhanJun on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FrameViewController.h"

@implementation FrameViewController


@synthesize myPageControl;
@synthesize framesv;
@synthesize titlelb;


#define kNumberOfPages 2
CGFloat currentpage = 0;
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

#define PageViewWidth  6.0
#define PageViewHeight 6.0

#define PageViewYGap   6.0
#define PageViewToTopRight 10
#define PageViewToTopup 38
#pragma mark - View lifecycle


#define fram_top 521
#define fram_left 1

#define fram_Width 552
#define fram_Height 226
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(fram_left,fram_top,fram_Width,fram_Height);
   
//    titlelb = [[UILabel alloc] init];
//    titlelb.backgroundColor = [UIColor clearColor];
//    titlelb.frame = CGRectMake(0, 15, detailViewWidth-15, 15);
//    titlelb.textAlignment = UITextAlignmentRight;
//    titlelb.textColor = [UIColor whiteColor];
//    titlelb.font = [UIFont systemFontOfSize:14];
//    titlelb.text = @"地板剖面示意图";
//    [self.view addSubview:titlelb];
    
    
//    UIPageControl *pageControll = [[[UIPageControl alloc] initWithFrame:CGRectMake((detailViewWidth-2-PageViewToTopRight), PageViewToTopup, 400, PageViewWidth)] autorelease];
//	self.myPageControl = pageControll;
//    
//	//[self.myPageControl setBounds:CGRectMake(0, 0, 5 * (kNumberOfPages - 1) + 5, 16)];
//	self.myPageControl.center = CGPointMake((detailViewWidth-2-(PageViewToTopRight+(PageViewWidth+PageViewWidth/2)*kNumberOfPages)), PageViewToTopup + PageViewHeight/2);
//    //    NSLog(@"tell me what  00  ?>>%f",self.myPageControl.center.x);
//    //    NSLog(@"tell me what>>>>>>>>>%f",self.myPageControl.center.y);
//	self.myPageControl.numberOfPages = kNumberOfPages;
//	[self.myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:self.myPageControl];
    
    framesv = [[BaseUIScrollView alloc] init];
    framesv.frame =CGRectMake(0,0,fram_Width,fram_Height);
    framesv.contentSize = CGSizeMake(fram_Width * kNumberOfPages,0);
    framesv.backgroundColor = [UIColor blackColor];
    framesv.pagingEnabled = YES;
    framesv.showsHorizontalScrollIndicator = NO;
    framesv.showsVerticalScrollIndicator = NO;
    framesv.delegate = self;
    framesv.userInteractionEnabled = YES;  
    framesv.scrollEnabled = YES;
    framesv.canCancelContentTouches = YES;
    framesv.bounces = YES;
    
    framesv.delaysContentTouches = NO;
    framesv.directionalLockEnabled = YES;
    framesv.alwaysBounceVertical = YES;
    [self.view addSubview:framesv];
    UIImageView *fingerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouzhi.png"]];
    fingerImage.frame = CGRectMake(480, 10, 50, 50);
    [self.view insertSubview:fingerImage aboveSubview:framesv];
    [fingerImage release];
    for (int i = 0; i<kNumberOfPages; i++) {
        NSString *imageName = [NSString stringWithFormat:@"jiegoutu%d.png",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        CGRect viewFrame = CGRectMake(fram_Width*i, 0, fram_Width, fram_Height);
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:viewFrame];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        
        imageView.tag = i;
        
        
        [self.framesv addSubview:imageView];  
        [imageView release];
    }

    
    
//    blowupview.view = [super view];
//    blowupview = [[BlowupView alloc]initWithNibName:@"BlowupView" bundle:[NSBundle mainBundle]];
//	[blowupview setSixview:self];
}

- (void) scrollViewDidScroll:(UIScrollView *)sender 
{
    CGFloat pageHight = framesv.frame.size.width;
    
    
    currentpage = floor((framesv.contentOffset.x - pageHight / 2) / pageHight) + 1;
//    self.myPageControl.currentPage = currentpage;
    
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)changePage:(id)sender{
    
//	int page = self.myPageControl.currentPage;
//    
//	CGRect frame = [self.view bounds];
//	frame.origin.x = frame.size.width*page;
//	frame.origin.y = 0;
//	[framesv scrollRectToVisible:frame animated:YES];
	
}
- (void)delButtonClicked:(id)sender
{
//    NSLog(@"@@@@@@");
//    UIScrollView *parentScrollView = (UIScrollView *)[self.view superview];
//    [parentScrollView setScrollEnabled:YES];
//    [blowupview.view removeFromSuperview];
}
- (IBAction)ButtonClicked:(id)sender
{
    
//    UIScrollView *parentScrollView = (UIScrollView *)[self.view superview];
//    [parentScrollView setScrollEnabled:NO];
//    [self.view addSubview:blowupview.view];
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

@end
