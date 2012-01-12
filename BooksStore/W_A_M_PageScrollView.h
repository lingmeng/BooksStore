//
//  W_A_M_PageScrollView.h
//  World_Architect_Magazine
//
//  Created by fei chen on 11-11-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "BaseUIScrollView.h"
#import "W_A_M_HomeViewController.h"
#import "VerticalScrollView.h"
#import "BaseViewController.h"


@class W_A_M_HomeViewController;


@interface W_A_M_PageScrollView : BaseViewController<UIScrollViewDelegate>
{
    int currentPages;
    int titlePages;//文章所在的页
    int totalPages;//文章内包含的页
}

@property (nonatomic, retain)  NSMutableArray *verticalSv;
@property(nonatomic,assign) int titlePages;
@property (nonatomic, retain) IBOutlet UIPageControl *myPageControl;
@property (nonatomic, retain) IBOutlet BaseUIScrollView *backsv;
@property(nonatomic, retain) NSMutableDictionary *titlePage;
@property (nonatomic, retain) W_A_M_HomeViewController *wamhomevc;

- (void)changePage:(id)sender;

- (void)PageControl:(NSInteger)kNumberOfPages;

//- (id)PagesLoadView:(int)currentPage;

- (void)loadScrollViewWithVerticalPage:(int)page;
@end

/*
 显示Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles -bool true
 defaults write com.apple.Finder AppleShowAllFiles YES
 defaults write com.apple.Finder AppleShowAllFiles NO
 隐藏Mac隐藏文件的命令：defaults write com.apple.finder AppleShowAllFiles -bool false
*/