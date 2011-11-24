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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!wamhvc) {
         wamhvc = [[W_A_M_HomeViewController alloc] init];
    }
    
    
    wamhvc.view.frame = CGRectMake(0, 0, 1024, 748);
    //[self.navigationController pushViewController:f animated:NO];
    
    //self.view =wamhvc.view;
   
    [self.view addSubview:wamhvc.view];
    //wamhvc.tabBarController=self.tabBarController;
    // wamhvc.tabBarController
   // SecondViewController *f=[[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    
    
    //self.tabBarController.selectedIndex=3;
     //[wamhvc.tabBarController s
   // self.tabBarController.tabBar.hidden = YES;
//    NSLog(@"sdsdhide");
    

}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"wa");
   [self hideBar];
}

- (void)switchme{
    NSLog(@"ssssss");
    self.tabBarController.selectedIndex=0;
    [self hideBar];
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    wamhvc.view = nil;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {	
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        wamhvc.view.frame = CGRectMake(0, 0, 768, 1004);
    }
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
        wamhvc.view.frame = CGRectMake(0, 0, 1024, 748);
    } 
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

@end
