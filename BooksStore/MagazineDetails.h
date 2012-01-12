//
//  MagazineDetails.h
//  BooksStore
//
//  Created by meng ling on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MagazineDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * MagazineId;
@property (nonatomic, retain) NSString * ContentImages;
@property (nonatomic, retain) NSString * MagazineCover;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) NSNumber * Price;
@property (nonatomic, retain) NSString * GroupName;

@end
