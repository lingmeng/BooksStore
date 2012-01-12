//
//  W_A_M_HomeViewController.h
//  World_Architect_Magazine
//
//  Created by fei chen on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "W_A_M_PageScrollView.h"
#import "MapViewController.h"
#import "MoviePlayViewController.h"
#import "BaseViewController.h"
#import "BaseUIScrollView.h"
@class AVPlayer;
@class MapViewController;
@class MoviePlayViewController;

@interface W_A_M_HomeViewController : BaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    UIImageView *pageImage;
    UIButton *listViewbtu;
    UILabel *numberlab;
    UIView *titlebv;
    UIImageView *infoimage;
    UIView *framebv;
    UIImageView *frameimage;
    UIImageView *playimage;
   // NSMutableArray *mta;
    //NSMutableArray *articles;
    //NSMutableArray *pages;
    
    
    int prevPage;
    BOOL shareClicked;
    BOOL shareClicked1;
    BOOL shareClicked2;
    BOOL shareClicked3;
    BOOL animation_hidden;
    BOOL infoClicked;
    BOOL mapClicked;
    BOOL frameClicked;
    BOOL frameClickedHidden;
    BOOL listClicked;
    BOOL pageControlUsed;
    BOOL movie_play;
	AVPlayer *player;
    UIButton *playbtu;
}

@property (nonatomic, retain) NSMutableArray *listbtuname;

@property (nonatomic, retain) AVPlayer *player;



@property (nonatomic, retain)  NSMutableArray *viewControllers;
@property(nonatomic, retain) UIImageView *detailView;
@property(nonatomic, retain) UIView *detailInfoView;
@property(nonatomic, retain) UIView *buttonbackView;
@property(nonatomic, retain) IBOutlet UIView *weiBoView;
@property(nonatomic, retain) IBOutlet   UIView *buttonView;
@property(nonatomic, retain) IBOutlet UIButton *listbtu,*talkbtu,*wbbtu,*homebtn,*leftbtu,*rightbtu;
@property(nonatomic, retain) IBOutlet UIButton *infobtu,*mapbtu,*framebtu,*playbtu;
@property(nonatomic, readwrite) NSInteger currentpage;
@property(nonatomic, retain) NSMutableArray *titlePageArray;
@property(nonatomic, retain) IBOutlet UIPageControl *myPageControl;
@property(nonatomic, retain) IBOutlet UIView *top_titleView;
@property(nonatomic, retain) IBOutlet UIView *down_titleView;
@property(nonatomic, retain) IBOutlet BaseUIScrollView *articleScrollView;
@property(nonatomic, retain)  BaseUIScrollView *listsv;
@property(nonatomic, retain) IBOutlet UIView *editeView;
@property(nonatomic, retain) IBOutlet BaseUIScrollView *editesv;
@property(nonatomic, retain) IBOutlet UIView *infoView;
@property(nonatomic, retain)  BaseUIScrollView *infosv;
@property(nonatomic, retain) IBOutlet BaseUIScrollView *framesv;
@property(nonatomic, retain) IBOutlet UIScrollView *pagesSV;
@property(nonatomic, retain) MapViewController *mapVc;
@property(nonatomic, retain) MoviePlayViewController *moviepVc;
- (void)loadScrollViewWithPage:(int)page;
- (IBAction)InfobuttonCilcked:(id)sender;
- (void)letterInfo:(int)pages;
- (IBAction)MapbuttonCilcked:(id)sender;
- (IBAction)FramebuttonCilcked:(id)sender;
- (IBAction)MoviePlayCilcked:(id)sender;
- (void)FrameInfo:(int)pages totalPage:(int)tPage;
- (IBAction)share:(id)sender;
- (void)showAnimation; 
- (void)hide;
- (void)listView:(int)TempcurrentPage;
- (IBAction)Senderweibo:(id)sender;
- (IBAction)forwardPage:(id)sender;
- (IBAction)backwardPage:(id)sender;
- (IBAction)Catalogbtu:(id)sender;
- (void)PageTranView:(id)sender;

@end
