//
//  Article.h
//  BooksStore
//
//  Created by meng ling on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject

@property (nonatomic, retain) NSString * ContentBgImage;
@property (nonatomic, retain) NSNumber * Id;
@property (nonatomic, retain) NSString * KeyWords;
@property (nonatomic, retain) NSString * Desc;

@end
