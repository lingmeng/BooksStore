//
//  BaseViewController.h
//  BookStore
//
//  Created by meng ling on 11-11-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "BaseParamUtil.h"

@interface BaseViewController : UIViewController

-(void) hideBar;
- (id)initWithPageNumber:(int)page;
-(NSInteger)needSychronize;
-(Boolean)sychronizeWithServ:(int)flag;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; 
@end
