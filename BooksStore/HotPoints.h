//
//  HotPoints.h
//  BooksStore
//
//  Created by meng ling on 11-12-10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HotPoints : NSManagedObject

@property (nonatomic, retain) NSNumber * ArticleId;
@property (nonatomic, retain) NSString * HotPointType;
@property (nonatomic, retain) NSNumber * HotPointViewStartX;
@property (nonatomic, retain) NSNumber * HotPointViewStartY;
@property (nonatomic, retain) NSNumber * HotPonitViewHeight;
@property (nonatomic, retain) NSNumber * HotPonitViewWidth;
@property (nonatomic, retain) NSNumber * Longitude;
@property (nonatomic, retain) NSNumber * Latitude;
@property (nonatomic, retain) NSNumber * PageNo;
@property (nonatomic, retain) NSString * ScrollViewImage;
@property (nonatomic, retain) NSString * VEDIOADDRESS;
@property (nonatomic, retain) NSString * URL;
@property (nonatomic, retain) NSString * InfomationImage;
@property (nonatomic, retain) NSString * ScrollViewRollType;
@property (nonatomic, retain) NSNumber * ScrollViewSize;

@end
