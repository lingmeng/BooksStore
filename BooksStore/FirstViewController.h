//
//  FirstViewController.h
//  BooksStore
//
//  Created by meng ling on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseViewController.h"
#import "BaseParamUtil.h"
@interface FirstViewController : BaseViewController<UIScrollViewDelegate>{
    NSString *documentsBookPath;
	NSString *bundleBookPath;
    UIScrollView *scrollView;

}

-(IBAction)startme:(id)sender;
-(IBAction)Magezines:(id)sender;

-(IBAction)clickcategorys:(id)sender;
@property (nonatomic, retain) NSString *documentsBookPath;
@property (nonatomic, retain) IBOutlet UIScrollView  *scrollView;
@property (nonatomic, retain) IBOutlet UIScrollView  *nextsv;
@property (nonatomic, retain) IBOutlet UIView  *nextbv;

@property (nonatomic, retain) IBOutlet UIScrollView  *signesv;
@property (nonatomic, retain) IBOutlet UIView  *signeView;

@property (nonatomic, retain) NSString *bundleBookPath;
@end
