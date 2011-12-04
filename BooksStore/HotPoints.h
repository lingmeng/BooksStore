//
//  HotPoints.h
//  BooksStore
//
//  Created by meng ling on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HotPoints : NSManagedObject

@property (nonatomic, retain) NSString * ArticleId;
@property (nonatomic, retain) NSString * HotPointType;
@property (nonatomic, retain) NSNumber * HotPointViewStartX;
@property (nonatomic, retain) NSNumber * HotPointViewStartY;
@property (nonatomic, retain) NSNumber * HotPonitViewHeight;
@property (nonatomic, retain) NSNumber * HotPonitViewWidth;
@property (nonatomic, retain) NSNumber * Id;
@property (nonatomic, retain) NSString * MapLocation;
@property (nonatomic, retain) NSNumber * PageNo;
@property (nonatomic, retain) NSString * ScrollViewImage;
@property (nonatomic, retain) NSString * Text;
@property (nonatomic, retain) NSString * URL;

@end
