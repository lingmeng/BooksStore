//
//  BooksStoreAppDelegate.m
//  BooksStore
//
//  Created by meng ling on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BooksStoreAppDelegate.h"


#import "FirstViewController.h"

#import "SecondViewController.h"

#import "ReadController.h"
#import "MemberCenterViewController.h"
#import "AboutUsViewController.h"

@implementation BooksStoreAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSLog(@"%f,%f",self.window.bounds.size.width,self.window.bounds.size.height);
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    UIViewController *viewController3 = [[ReadController alloc] initWithNibName:@"ReadController" bundle:nil];
    UIViewController *viewController4 = [[MemberCenterViewController alloc] initWithNibName:@"MemberCenterViewController" bundle:nil];
    UIViewController *viewController5 = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBarController.tabBar setAlpha:0.8];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4,viewController5,nil];
    
    self.window.rootViewController = self.tabBarController;
    //self.tabBarController.tabBar.hidden=YES;
    [self hideTabBar:YES];
    [self.window setBackgroundColor:[UIColor grayColor]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) hideTabBar:(BOOL) hidden
{  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y+49,  view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y,  view.frame.size.width, view.frame.size.height)];
            }
        } 
        else 
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y,  view.frame.size.width, view.frame.size.height+49)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y,  view.frame.size.width, view.frame.size.height)];
            }
        }
    }
    [UIView commitAnimations];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
