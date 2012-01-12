//
//  MoviePlayViewController.m
//  BooksStoreNew
//
//  Created by fei chen on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MoviePlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@implementation MoviePlayViewController
@synthesize wamhomeVc;
@synthesize player;

CGRect normalsize;
CGRect maxsize;

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

    wamhomeVc = [[W_A_M_HomeViewController alloc] init];
    [wamhomeVc setMoviepVc:self];
    self.view.frame = CGRectMake(0, 0, 280,180);
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xt_14_1.jpg"]];
   
    NSString *url = [[NSBundle mainBundle] pathForResource:@"02movie" ofType:@"mov"];
    //NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"cyborg" ofType:@"m4v"];
	self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:url]];
    //	[self.player play];
	
	// Create and configure AVPlayerLayer
	AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
	playerLayer.bounds = CGRectMake(0, 0, 280, 180);
	playerLayer.position = self.view.center;//CGPointMake(160, 150);
	playerLayer.borderColor = [UIColor whiteColor].CGColor;
	playerLayer.borderWidth = 3.0;
	playerLayer.shadowOffset = CGSizeMake(0, 3);
	playerLayer.shadowOpacity = 0.80;
    
    // Add perspective transform
	//self.view.layer.sublayerTransform = CATransform3DMakePerspective(1000);	
	[self.view.layer addSublayer:playerLayer];
    playbtu = [UIButton buttonWithType:UIButtonTypeCustom];
    playbtu.frame= CGRectMake(0, 0, 38, 37);
    playbtu.center = self.view.center;
    [self.view addSubview:playbtu];
    [playbtu addTarget:self action:@selector(showmovie) forControlEvents:UIControlEventTouchUpInside];
    playbtu.tag = 212;
    [playbtu setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
    isNormalSize =YES;
//    normalsize=CGRectMake(856, 690, 0, 0);
//    maxsize=CGRectMake(0, 0, 1024, 748);
    normalsize=CGRectMake(0, 0, 280,180);
    maxsize=CGRectMake(0, 0, 280, 180);
    mover = [[UIImageView alloc] initWithFrame:normalsize];
    mover.userInteractionEnabled=YES;
}
////begain movie play
int movie_play = 0;
-(void)showmovie{
    
    if (movie_play) {
       movie_play = 0;
        [self.player pause];
    }else
    {
        movie_play = 1;
        [self.player play];
    }
//    [self playmovie];

}

- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];  
    
    [playerViewController.view removeFromSuperview];
    [self movemovieframe];
    //[player autorelease]; 
    //if(musicoff==0)
    
    
    
}

-(void)unloadMovie{
    [mover release];
    
    [mover removeFromSuperview];
    
    [wamhomeVc MoviePlayCilcked:self];
}

-(void)loadMovie{
    
    
    
    
    //-- add to view--- tbumbnail
    //playerViewController.
    /*UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
     [imgv setImage:image];
     
     [imgv release];
     */
    //[self movemovieframe];
    //---play movie---  
    // [mover addSubview: playerViewController.view]; 
    [self.view  addSubview: playerViewController.view];
    MPMoviePlayerController *player = [playerViewController moviePlayer];  
    [player play];
}

-(void)loadmoviefile{
    NSString *url = [[NSBundle mainBundle] 
                     pathForResource:@"02movie" 
                     ofType:@"mov"];
    
    playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:url]];  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:)  
                                                 name:MPMoviePlayerPlaybackDidFinishNotification  
                                               object:[playerViewController moviePlayer]];
}
-(void)playmovie{
    
    [self loadmoviefile];
    UIImage *image = [playerViewController.moviePlayer  thumbnailImageAtTime:(NSTimeInterval)2.1 timeOption: MPMovieTimeOptionNearestKeyFrame];
    // NSData *imgData = UIImagePNGRepresentation(image);
    //  NSLog(@"\n length of ThumbnailImage Data...%d",[imgData length]);
     mover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 180)];
//    mover = [[UIImageView alloc] initWithFrame:CGRectMake(856, 690, 0, 0)];
    [mover setImage:image];
    // [mover setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:mover]; 
    
    
    [self movemovieframe];
    
    /* */  
}

-(void)movemovieframe{
    [UIView beginAnimations:@"toopa" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    if (!isNormalSize) {
        [UIView setAnimationDidStopSelector:@selector(unloadMovie)];
//        [mover setFrame:CGRectMake(856, 690, 0, 0)];  
         [mover setFrame:CGRectMake(0, 0, 280, 180)];  
    }
    else
    {
        [UIView setAnimationDidStopSelector:@selector(loadMovie)];
//        [mover setFrame:CGRectMake(0, 0, 1024, 768)];
         [mover setFrame:CGRectMake(0, 0, 280, 180)];  
    }
    
    [UIView commitAnimations];
    isNormalSize=!isNormalSize;
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self.player pause];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
