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
#import "SecondViewController.h"
@interface FirstViewController : BaseViewController<UIScrollViewDelegate>{
    NSString *documentsBookPath;
	NSString *bundleBookPath;
    BaseUIScrollView *scrollView;
    UILabel *priceLabel;
    UIButton *paybutton;
    UILabel *description;
    UIImageView *cover;
    UILabel *groupLabel;
    
    
}

-(IBAction)startme:(id)sender;
-(IBAction)Magezines:(id)sender;
-(void)loadMagezinesNumberWithGroupId:(int)groupid;
-(IBAction)clickcategorys:(id)sender;


-(Boolean)buyMagazineById:(int)magazineid;
-(Boolean)loadMagezines;
-(void)loadSingeMagezinesWithId:(int)magazineId;
//-(IBAction)downloadPaidMagazineWithId:(id)sender;
@property (nonatomic, retain) NSString *documentsBookPath;
@property (nonatomic, retain) IBOutlet BaseUIScrollView  *scrollView;
@property (nonatomic, retain) IBOutlet UIScrollView  *nextsv;
@property (nonatomic, retain) IBOutlet UIView  *nextbv;
@property (nonatomic, retain) IBOutlet UIImageView  *cover;
@property (nonatomic, retain) IBOutlet UIButton  *paybutton;

@property (nonatomic, retain) IBOutlet UIScrollView  *signesv;
@property (nonatomic, retain) IBOutlet UIView  *signeView;
@property (nonatomic, retain) IBOutlet UILabel  *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel  *description;
@property (nonatomic, retain) IBOutlet UILabel  *groupLabel;
@property (nonatomic, retain) NSString *bundleBookPath;
@end
