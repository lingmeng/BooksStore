//
//  TitilepageTwo.h
//  BooksStore
//
//  Created by fei chen on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "BaseUIScrollView.h"
#import "W_A_M_HomeViewController.h"


#import "BaseViewController.h"


#import "LetterViewController.h"
#import "FrameViewController.h"
#import "MapViewController.h"



@class LetterViewController;
@class FrameViewController;
@class MapViewController;
@class ListViewController;

@class W_A_M_HomeViewController;

@interface TitilepageTwo : UIViewController<UIScrollViewDelegate>
{
    UIView *titlebv;
    UIView *letterbv;
    UIButton *frameColsebtu;
}






//@property(nonatomic, retain) IBOutlet UIPageControl *myPageControl;
//@property(nonatomic, retain) IBOutlet BaseUIScrollView *backsv;
//@property(nonatomic, retain) IBOutlet UIScrollView *titleSv;
//
//@property(nonatomic, retain) UIImageView *imageView;
//
//
//@property(nonatomic, retain) W_A_M_HomeViewController *wamhomevc;
//
//@property(nonatomic, retain) LetterViewController *lettervc;
//@property(nonatomic, retain) FrameViewController *framevc;
//@property(nonatomic, retain) MapViewController *mapvc;
//@property(nonatomic, retain) ListViewController *listvc;

- (void)changePage:(id)sender;

- (void)addLetterView:(id)sender;
- (void)addFrameView:(id)sender;

- (void)PageControl:(NSInteger)kNumberOfPages;


@end
