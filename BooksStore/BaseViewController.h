//
//  BaseViewController.h
//  BookStore
//
//  Created by meng ling on 11-11-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
#import "BaseParamUtil.h"
#import "MagazineGroup.h"
#import "MagazineListPreView.h"
#import "PaidMagazineListPreView.h"
#import "MagazineToArticle.h"
#import "Article.h"
#import "Pages.h"
#import "HotPoints.h"
#import "MagazineDetails.h"
#import "ASIHTTPRequest.h"

#import "BooksStoreAppDelegate.h"
#import "ZipArchive.h"
#import "Reachability.h"
#import "MyBookView.h"
#import "ArticleVO.h"

@class ASINetworkQueue;
@interface BaseViewController : UIViewController<ASIHTTPRequestDelegate>{
ASINetworkQueue *networkQueue;
    //UIProgressView *progressIndicator;
    BOOL failed;
    int choosedMagazineId;
    int loadok;
    UIProgressView *zztjProView;//系统的进度条
    //NSMutableDictionary *titlePage;
}


-(void) hideBar;
-(id)initWithPageNumber:(int)page;
-(NSInteger)needSychronize;
-(Boolean)sychronizeGroup;
-(Boolean)sychronizeBooks;
-(Boolean)saveMagezineXmlWithBookId:(int)bookID;
//-(Boolean)sychronizeWithServ:(int)flag;
-(void)synchronizeApp;
-(void)showMessageAnimationatView;
-(NSString *)getDocumentDirectory;
//-(void)URLFetchWithProgressComplete:(ASIHTTPRequest *)request;
-(void)writeVersionToSystemWithType:(int)uploadtype;

-(void)downloadBookListFiles;





-(void)downloadGroupFiles;
- (NSMutableArray *)retrieveDataWithEntityName: (NSString *)entityName fetchLimit:(int)fetchLimit predicate:(NSPredicate *)predicate  
                                    orderField:(NSString *)orderField isAscending:(BOOL)isAscending inManagedObjectContext:(NSManagedObjectContext *)moc;

-(void)unZipFromfilepath:(NSString *)filePath tofilepath:(NSString *)unZipPath;

-(Boolean)isconnectok;


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext; 
@property (nonatomic,assign)int choosedMagazineId;
@property(nonatomic, retain) NSMutableArray *mtalist;
@property(nonatomic, retain) NSMutableArray *articleslist;
@property(nonatomic, retain) NSMutableArray *pageslist;
@property (nonatomic, retain)  NSMutableArray *contentList;
@end
