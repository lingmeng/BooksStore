//
//  LetterViewController.m
//  World_Architect_Magazine
//
//  Created by ZhanJun on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "LetterViewController.h"

@implementation LetterViewController

@synthesize lettersv;
@synthesize infoText;
NSInteger kNumberOfPages;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    lettersv.frame = CGRectMake(0, 0, 667, 681);
    kNumberOfPages =1;
    lettersv.contentSize = CGSizeMake(1000,1193 * (kNumberOfPages)+221);
   
    lettersv.pagingEnabled = NO;
    lettersv.showsHorizontalScrollIndicator = NO;
    lettersv.showsVerticalScrollIndicator = YES;
    lettersv.delegate = self;
    lettersv.userInteractionEnabled = YES;  
    lettersv.scrollEnabled = YES;
    lettersv.canCancelContentTouches = YES;
    lettersv.bounces = YES;
 
    
    lettersv.delaysContentTouches = NO;
    lettersv.directionalLockEnabled = YES;
    lettersv.alwaysBounceVertical = YES;
    [self.view addSubview:self.lettersv ];
    for (int i = 0; i<kNumberOfPages; i++) {
        NSString *imageName = [NSString stringWithFormat:@"wenzi.png"];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        CGRect viewFrame = CGRectMake(0,0, 1024, 1193);
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:viewFrame];
        imageView.image = image;
        [self.lettersv addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        
        imageView.tag = i;
        
        
        [self.lettersv addSubview:imageView]; 
        [imageView release];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

@end
