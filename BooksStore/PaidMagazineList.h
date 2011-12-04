//
//  PaidMagazineList.h
//  BooksStore
//
//  Created by meng ling on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PaidMagazineList : NSManagedObject

@property (nonatomic, retain) NSNumber * Id;
@property (nonatomic, retain) NSNumber * IsExsist;
@property (nonatomic, retain) NSString * MagazineId;

@end
