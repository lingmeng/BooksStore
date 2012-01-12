//
//  VerticalScrollView.m
//  BooksStoreNew
//
//  Created by fei chen on 11-12-13.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "VerticalScrollView.h"

@implementation VerticalScrollView

@synthesize currentPages,titlePage;

- (void)viewDidLoad
{
    NSMutableDictionary *pagesofarticle= [self.contentList objectAtIndex:titlePage];//得到一篇文章的doc,titlePage 确定文章 currentPages确定页
    
    NSString * imagePath = [pagesofarticle valueForKey:[NSString stringWithFormat:@"%d",currentPages+1]];//得到某页的图片
   
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:imagePath]];
    //显示热点锚点
    
}



@end
