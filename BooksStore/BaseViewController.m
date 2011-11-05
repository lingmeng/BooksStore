//
//  BaseViewController.m
//  BookStore
//
//  Created by meng ling on 11-11-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) hideTabBar:(BOOL) hidden
{  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 768, view.frame.size.width, view.frame.size.height)];
            } else {
              
                [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
            }
        } 
        else 
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 768)];
            } else {
                
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 768-49)];
            }
        }
    }
    [UIView commitAnimations];
}
bool ishidden=YES;
-(void)hideBar{
    
    if (ishidden) {
        
        [self hideTabBar:NO];
        ishidden=NO;
    }
    else
    { 
        
        [self hideTabBar:YES];
        ishidden=YES;
    }
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
