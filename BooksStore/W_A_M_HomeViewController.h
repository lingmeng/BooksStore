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
#import "LetterViewController.h"
#import "FrameViewController.h"
#import "MapViewController.h"

#import "BaseViewController.h"
#import "BaseUIScrollView.h"
@class W_A_M_PageScrollView;
@class LetterViewController;
@class FrameViewController;
@class MapViewController;
@class ListViewController;


@interface W_A_M_HomeViewController : BaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    UIImageView *pageImage;
    
    UIImageView *imageView;
    UILabel *numberlab;
    
    BOOL shareClicked;
    BOOL shareClicked1;
    BOOL shareClicked2;
    BOOL shareClicked3;
    BOOL animation_hidden;
    BOOL letterClicked;
    BOOL mapClicked;
    BOOL frameClicked;
    BOOL listClicked;
}
@property(nonatomic, retain) UIImageView *detailView;
@property(nonatomic, retain) UIView *detailInfoView;
@property(nonatomic, retain) UIView *buttonbackView;
@property(nonatomic, retain) IBOutlet UIView *weiBoView;
@property(nonatomic, retain) IBOutlet UIButton *listbtu,*talkbtu,*wbbtu,*homebtn;
@property(nonatomic, retain) LetterViewController *lettervc;
@property(nonatomic, retain) FrameViewController *framevc;
@property(nonatomic, retain) MapViewController *mapvc;
@property(nonatomic, retain) ListViewController *listvc;
@property(nonatomic, readwrite) NSInteger currentpage;
@property(nonatomic, retain) NSMutableArray *titlePageArray;
//@property(nonatomic, retain) IBOutlet UIView *titleView;

@property(nonatomic, retain) IBOutlet UIView *top_titleView;
@property(nonatomic, retain) IBOutlet UIView *down_titleView;
@property(nonatomic, retain) IBOutlet BaseUIScrollView *articleScrollView;
@property (nonatomic, retain) IBOutlet BaseUIScrollView *listsv;
@property(nonatomic, retain) W_A_M_PageScrollView *wampsv;

- (IBAction)share:(id)sender;
- (void)showAnimation; 

- (void)hiddenView;

- (void)hide;

- (void)showInfoAnimation;
- (void)listView;
- (void)hideInfo;

- (void)Auto_Hidden_Title_Show_Animation;
- (void)Auto_Hidden_Title_Hidden_Animation;
- (IBAction)Senderweibo:(id)sender;
- (IBAction)forwardPage:(id)sender;
- (IBAction)backwardPage:(id)sender;
- (IBAction)Catalogbtu:(id)sender;
- (void)tabBarController:(UITabBarController *)barController didSelectViewController:(UIViewController *)viewController;

- (void)switchme;

@end
