//
//  FrameViewController.h
//  World_Architect_Magazine
//
//  Created by ZhanJun on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "BaseUIScrollView.h"
@interface FrameViewController : BaseViewController <UIScrollViewDelegate>



@property(nonatomic, retain) IBOutlet UIPageControl *myPageControl;

@property(nonatomic, retain) BaseUIScrollView *framesv;

@property(nonatomic, retain) UILabel *titlelb;

- (IBAction)ButtonClicked:(id)sender;
- (void)delButtonClicked:(id)sender;
@end
