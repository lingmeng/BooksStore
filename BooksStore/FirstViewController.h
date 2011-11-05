//
//  FirstViewController.h
//  BooksStore
//
//  Created by meng ling on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
@interface FirstViewController : BaseViewController{
    NSString *documentsBookPath;
	NSString *bundleBookPath;
   }
-(IBAction)startme:(id)sender;
-(IBAction)clickcategorys:(id)sender;
@property (nonatomic, retain) NSString *documentsBookPath;
@property (nonatomic, retain) NSString *bundleBookPath;
@end
