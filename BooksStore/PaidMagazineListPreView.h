//
//  PaidMagazineListPreView.h
//  BooksStore
//
//  Created by meng ling on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PaidMagazineListPreView : NSManagedObject

@property (nonatomic, retain) NSNumber * GroupId;
@property (nonatomic, retain) NSString * GroupName;
@property (nonatomic, retain) NSString * MagazineCover;
@property (nonatomic, retain) NSNumber * MagazineId;
@property (nonatomic, retain) NSNumber * Period;
@property (nonatomic, retain) NSString * Mtype;
@property (nonatomic, retain) NSNumber * isExsisit;

@end
