//
//  BaseViewController.h
//  BookStore
//
//  Created by meng ling on 11-11-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
#import "BaseParamUtil.h"
#import "MagazineGroup.h"
#import "MagazineListPreView.h"
#import "PaidMagazineList.h"
#import "MagazineToArticle.h"
#import "Article.h"
#import "HotPoints.h"
#import "ASIHTTPRequest.h"
@class ASINetworkQueue;
@interface BaseViewController : UIViewController{
ASINetworkQueue *networkQueue;
    UIProgressView *progressIndicator;
    BOOL failed;
}


-(void) hideBar;
-(id)initWithPageNumber:(int)page;
-(NSInteger)needSychronize;
-(Boolean)sychronizeGroup;
-(Boolean)sychronizeBooks;
-(Boolean)sychronizeWithServ:(int)flag;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; 
@end
