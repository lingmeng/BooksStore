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

#import "FavoriteViewController.h"


@implementation BooksStoreAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //NSLog(@"%f,%f",self.window.bounds.size.width,self.window.bounds.size.height);
    // Override point for customization after application launch.
    
    BaseViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    BaseViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    BaseViewController *viewController3 = [[ReadController alloc] initWithNibName:@"ReadController" bundle:nil];
    BaseViewController *viewController4 = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
    BaseViewController *viewController5 = [[MemberCenterViewController alloc] initWithNibName:@"MemberCenterViewController" bundle:nil];
    BaseViewController *viewController6 = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    //[self.tabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
   
    [self.tabBarController.tabBar setAlpha:0.8];
//    self.tabBarController.tabBar.frame = CGRectMake(0, 748-49, 1024, 49);
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4,viewController5,viewController6,nil];
    
    self.window.rootViewController = self.tabBarController;
    //self.tabBarController.tabBar.hidden=YES;
    //[self hideTabBar:YES];
    
    
//    for(UIView *view in self.tabBarController.view.subviews)
//    {
//        if ([view isKindOfClass:[UITabBar class]]) {
//            [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
//        }
//    }
     NSManagedObjectContext *context = [self managedObjectContext];  
    [self.window setBackgroundColor:[UIColor grayColor]];
    [self.window makeKeyAndVisible];
    viewController1.managedObjectContext=context;
    viewController2.managedObjectContext=context;
    viewController3.managedObjectContext=context;
    viewController4.managedObjectContext=context;
    viewController5.managedObjectContext=context;
    viewController6.managedObjectContext=context;
    [viewController1 release];
    [viewController2 release];
    [viewController3 release];
    [viewController4 release];
    [viewController5 release];
    [viewController6 release];
    //viewController1.parentViewController
    [self.tabBarController release];
    return YES;
    
}

- (void) hideTabBar:(BOOL) hidden
{  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
//        NSLog(@"hide TabBar");
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
//                NSLog(@"hide TabBar 111");
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y+49,  view.frame.size.width, view.frame.size.height)];
//                 NSLog(@"ssssssssssss%f",view.frame.origin.y+49);
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y,  view.frame.size.width, view.frame.size.height)];
//                NSLog(@"aaaaaaaaaaa%f",view.frame.origin.y);
            }
        } 
        else 
        {
            if (hidden) {
//                NSLog(@"hide TabBar 222");
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y,  view.frame.size.width, view.frame.size.height+49)];
                
//                NSLog(@"wwwwwwwwww%f",view.frame.origin.y+49);
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x,view.frame.origin.y,  view.frame.size.width, view.frame.size.height)];
//                NSLog(@"qqqqqqqqq%f",view.frame.origin.y);
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


 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
     NSLog(@"currentController why index:%d",self.tabBarController.selectedIndex);  
     UIViewController  *currentController =self.tabBarController.selectedViewController;  
     NSLog(@"currentController why : %@",currentController);  
     self.tabBarController.selectedIndex = 0; 
 }



 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
     NSLog(@"currentController why why why index:%d",self.tabBarController.selectedIndex);  
     UIViewController  *currentController =self.tabBarController.selectedViewController;  
     NSLog(@"currentController why why why : %@",currentController);  
     self.tabBarController.selectedIndex = 0; 
 }

 //Core Data
@synthesize managedObjectContext=__managedObjectContext;//session  

@synthesize managedObjectModel=__managedObjectModel;  

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;  



//相当与持久化方法  
- (void)saveContext  
{  
    NSError *error = nil;  
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;  
    if (managedObjectContext != nil)  
    {  
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])  
        {  
            /* 
             Replace this implementation with code to handle the error appropriately. 
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button. 
             */  
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);  
            abort();  
        }   
    }  
}  


#pragma mark - Core Data stack  

/** 
 Returns the managed object context for the application. 
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application. 
 */  
//初始化context对象
- (NSManagedObjectContext *)managedObjectContext{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }//这里的URLForResource:@"lich" 的url名字（lich）要和你建立datamodel时候取的名字是一样的，至于怎么建datamodel很多教程讲的很清楚
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"storage" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    //这个地方的lich.sqlite名字没有限制，就是一个数据库文件的名字
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"storage.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
