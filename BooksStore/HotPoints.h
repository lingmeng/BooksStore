//
//  HotPoints.h
//  BooksStore
//
//  Created by meng ling on 12-1-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HotPoints : NSManagedObject

@property (nonatomic, retain) NSNumber * ArticleId;
@property (nonatomic, retain) NSString * HType;
@property (nonatomic, retain) NSNumber * HViewStartX;
@property (nonatomic, retain) NSNumber * HViewStartY;
@property (nonatomic, retain) NSNumber * HViewHeight;
@property (nonatomic, retain) NSNumber * HViewWidth;
@property (nonatomic, retain) NSString * InfomationImage;
@property (nonatomic, retain) NSNumber * Latitude;
@property (nonatomic, retain) NSNumber * Longitude;
@property (nonatomic, retain) NSNumber * HPageNo;
@property (nonatomic, retain) NSString * ScrollViewImage;
@property (nonatomic, retain) NSString * ScrollViewRollType;
@property (nonatomic, retain) NSNumber * ScrollViewSize;
@property (nonatomic, retain) NSString * URL;
@property (nonatomic, retain) NSString * VEDIOADDRESS;
@property (nonatomic, retain) NSNumber *  HBtnStartX;
@property (nonatomic, retain) NSNumber *  HBtnStartY;
@property (nonatomic, retain) NSNumber *  HBtnHeight;
@property (nonatomic, retain) NSNumber *  HBtnWidth;
@property (nonatomic, retain) NSString * HBtnNormal;
@property (nonatomic, retain) NSString * HBtnClick;
@property (nonatomic, retain) NSNumber *  HLevel;
@property (nonatomic, retain) NSNumber *  HParent;
@property (nonatomic, retain) NSString * ShowType;

@end
