//
//  ReadController.h
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

#import "BaseUIScrollView.h"
#import "W_A_M_HomeViewController.h"
@interface ReadController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, retain)W_A_M_HomeViewController *wamhvc;
/*@property (nonatomic, retain) IBOutlet UIView *top_titleView;
@property(nonatomic, retain) IBOutlet UIView *down_titleView;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet BaseUIScrollView *magazineScrollView;
@property (nonatomic, retain) NSMutableArray *viewControllers;
- (void)loadScrollViewWithPage:(int)page;*/
@end
