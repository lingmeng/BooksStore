//
//  MagazineGroup.h
//  BooksStore
//
//  Created by meng ling on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MagazineGroup : NSManagedObject

@property (nonatomic, retain) NSString * GroupCover;
@property (nonatomic, retain) NSNumber * GroupId;
@property (nonatomic, retain) NSNumber * Id;
@property (nonatomic, retain) NSString * GroupName;
@property (nonatomic, retain) NSNumber * GVersion;
@end
