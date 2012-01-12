//
//  BaseUIScrollView.m
//  BooksStore
//
//  Created by meng ling on 11-11-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseUIScrollView.h"

@implementation BaseUIScrollView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"ssss1");
    /*if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
     //   NSLog(@"touches began ssss2");
    }*/
    //[super touchesBegan:touches withEvent:event];
//    NSLog(@"MyScrollView touch Began11");
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touches moveed  ssss");
    if(!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
//        NSLog(@"touches moveed if ssss");
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touches ended  ssss");
    if(!self.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
//        NSLog(@"touches ended if ssss");
    }
    [super touchesEnded:touches withEvent:event];
}
@end
