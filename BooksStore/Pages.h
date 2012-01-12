//
//  Pages.h
//  BooksStore
//
//  Created by meng ling on 11-12-30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pages : NSManagedObject

@property (nonatomic, retain) NSNumber * ArticleId;
@property (nonatomic, retain) NSString * ContentBgImage;
@property (nonatomic, retain) NSNumber * PageNo;

@end
