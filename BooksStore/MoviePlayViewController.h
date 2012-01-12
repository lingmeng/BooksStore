//
//  MoviePlayViewController.h
//  BooksStoreNew
//
//  Created by fei chen on 11-12-8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "W_A_M_HomeViewController.h"

@class W_A_M_HomeViewController;
@class AVPlayer;
@interface MoviePlayViewController : UIViewController
{
    BOOL isNormalSize;
    MPMoviePlayerViewController *playerViewController;
    UIImageView *mover;
	AVPlayer *player;
    UIButton *playbtu;
}

@property (nonatomic, retain) AVPlayer *player;
@property(nonatomic, retain) W_A_M_HomeViewController *wamhomeVc;
-(void)playmovie;
-(void)movemovieframe;
-(void)showmovie;
@end
