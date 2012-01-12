//
//  BooksStoreAppDelegate.h
//  BooksStore
//
//  Created by meng ling on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"
@class ASINetworkQueue;
@interface BooksStoreAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    
     UITabBarController *tabBarController;
//CFRunLoopRef currentLoop;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;  
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;  


- (void)saveContext;  
- (NSURL *)applicationDocumentsDirectory; 

- (void) hideTabBar:(BOOL) hidden;
/*-(NSInteger)needSychronize;
-(Boolean)sychronizeGroup;
-(Boolean)sychronizeBooks;
-(Boolean)sychronizeWithServ:(int)flag;
-(void)synchronizeApp;
-(void)showMessageAnimationatView;
*/

@end


