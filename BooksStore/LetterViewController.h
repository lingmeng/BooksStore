//
//  LetterViewController.h
//  World_Architect_Magazine
//
//  Created by ZhanJun on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LetterViewController : BaseViewController<UIScrollViewDelegate>


@property(nonatomic, retain) IBOutlet UIScrollView *lettersv;
@property(nonatomic, retain) IBOutlet UITextView *infoText;
@end
