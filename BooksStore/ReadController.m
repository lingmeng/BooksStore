//
//  ReadController.m
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReadController.h"
#import "SecondViewController.h"
@implementation ReadController
@synthesize wamhvc;
//@synthesize top_titleView,down_titleView,titleLabel,magazineScrollView,viewControllers;//wamhvc,
NSArray *SkipButtonArray;
int pageNumber=0;
Boolean pageControlUsed = YES;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"阅读", @"阅读");
        self.tabBarItem.image = [UIImage imageNamed:@"阅读"];
      //  self.tabBarController.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)loadReadContent{
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hideBar];

    if(!choosedMagazineId||choosedMagazineId==0)
    {
        //载入最新一期杂志
        
    }
    else
    {
        //载入选中的杂志
        
    }
    
    if (!wamhvc) {
        wamhvc = [[W_A_M_HomeViewController alloc] init];
        //         wamhvc.view.frame = CGRectMake(0, 0, 1024, 748);
        wamhvc.choosedMagazineId=self.choosedMagazineId;
        //self.view=wamhvc.view;
       
        [self.view addSubview:wamhvc.view];
        //self.view =wamhvc.view;
    }
    [wamhvc viewWillAppear:animated];
}

- (void)switchme{

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   // wamhvc.view = nil;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {	
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
  ////      wamhvc.view.frame = CGRectMake(0, 0, 768, 1004);
    }
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
     //   wamhvc.view.frame = CGRectMake(0, 0, 1024, 748);
    } 
}



@end
