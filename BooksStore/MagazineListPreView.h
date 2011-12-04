//
//  MagazineListPreView.h
//  BooksStore
//
//  Created by meng ling on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MagazineListPreView : NSManagedObject

@property (nonatomic, retain) NSNumber * GroupId;
@property (nonatomic, retain) NSNumber * Id;
@property (nonatomic, retain) NSString * MagazineCover;
@property (nonatomic, retain) NSString * MagazineId;
@property (nonatomic, retain) NSString * MType;
@property (nonatomic, retain) NSNumber * Period;
@property (nonatomic, retain) NSNumber * Price;
@property (nonatomic, retain) NSString * SmallImages;

@end
