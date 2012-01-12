//
//  VerticalScrollView.h
//  BooksStoreNew
//
//  Created by fei chen on 11-12-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface VerticalScrollView : BaseViewController
{
    int currentPages;
    int titlePage;
}
//@property (nonatomic, retain)  NSArray *contentListPage;
@property (nonatomic, assign) int currentPages;
@property (nonatomic, assign) int titlePage;
//- (id)PagesLoadView:(int)currentPage titlePage:(int)titlePages;
@end
