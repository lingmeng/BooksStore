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
@synthesize contentList;
@synthesize verticalSv,titlePages,titlePage;
NSInteger currentpage ;
NSInteger kNumberOfPages ;


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

#define fram_top 504
#define fram_left 9

#define fram_Width 555
#define fram_Height 235
CGRect normalsize;
CGRect maxsize;

/*
- (id)PagesLoadView:(int)currentPage
{
    self = [super initWithNibName:@"W_A_M_PageScrollView" bundle:[NSBundle mainBundle]];
    if (self) {
        // Custom initialization
        titlePages = currentPage;
    }
    return self;
}*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    titlePage = [self.contentList objectAtIndex:titlePages];
   
    NSString * Pages = [titlePage valueForKey:@"Pages"];//得到某一篇文章有多少页
    
    
    //文章的页码
    totalPages = [Pages intValue];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < totalPages; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    self.verticalSv = controllers;//verticalSv 纵向列表数量
    [controllers release];
    
    
    // Do any additional setup after loading the view from its nib.
 
   //上下滚动，某文章的各个页
    backsv.contentSize = CGSizeMake(0,748 * totalPages);
    backsv.backgroundColor = [UIColor blackColor];
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
    [self loadScrollViewWithVerticalPage:0];
    [self loadScrollViewWithVerticalPage:1];

    [backsv release];

    [self PageControl:totalPages]; 
  
    

  

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
//    [self loadScrollViewWithVerticalPage:currentpage-1];
//    [self loadScrollViewWithVerticalPage:currentpage+1];
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
#define PageViewToTopDown 38


- (void)PageControl:(NSInteger)kNumberOfPages 
{
    if (kNumberOfPages == 0) {
        
    }
   // NSLog(@"tell me what");
    UIPageControl *pageControll =[[UIPageControl alloc] initWithFrame:CGRectMake(PageViewToTopLeft, ((PageViewHeight+PageViewHeight)*kNumberOfPages-PageViewHeight), 748, PageViewWidth)];
	self.myPageControl = pageControll;
    [pageControll release];
	self.myPageControl.center = CGPointMake(PageViewToTopLeft+PageViewWidth/2, self.view.frame.size.height-((PageViewHeight/2+PageViewHeight)*kNumberOfPages+PageViewToTopDown));
	self.myPageControl.numberOfPages = kNumberOfPages;
	[self.myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    myPageControl.transform = transform;
    
	[self.view insertSubview:self.myPageControl aboveSubview:self.backsv];
    [myPageControl release];
}


////.....
#pragma customer method
-(void)removeLastContentWithIndex:(NSInteger)page {
    if (page < 1)
        return;
    if (page >= totalPages)
        return;
    VerticalScrollView *lastView = (VerticalScrollView *)[verticalSv objectAtIndex:page];
    if ((NSNull *)lastView != [NSNull null]) {
        
        [lastView.view removeFromSuperview];
        [self.verticalSv replaceObjectAtIndex:page withObject:[NSNull null]];
    } 
}
//
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageHeight = scrollView.frame.size.height;
    int page = floor((scrollView.contentOffset.y- pageHeight / 2) / pageHeight) + 1;
    currentpage = page;
    //.....
    [self removeLastContentWithIndex:page-2]; 
    [self removeLastContentWithIndex:page+2];
    //.....
    [self loadScrollViewWithVerticalPage:page - 1];
    [self loadScrollViewWithVerticalPage:page];
    [self loadScrollViewWithVerticalPage:page + 1];
}

- (void)loadScrollViewWithVerticalPage:(int)page{
    if (page < 0)
        return;
    if (page >= totalPages)
        return;

    VerticalScrollView *controller = [verticalSv objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
         controller=[[VerticalScrollView alloc] initWithNibName:@"VerticalScrollView" bundle:[NSBundle mainBundle]];
        //controller = [[VerticalScrollView alloc]PagesLoadView:page titlePage:titlePages];
        controller.contentList=self.contentList;
        controller.currentPages = page;//文章内部的页
        controller.titlePage = self.titlePages;//文章
        
        [verticalSv replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    if (controller.view.superview == nil)
    {
        CGRect frame = backsv.frame;
        frame.origin.x = 0;
        frame.origin.y = 748* page;
        controller.view.frame = frame;
        controller.view.userInteractionEnabled = YES;
        [backsv addSubview:controller.view];
    } 
}



@end
