//
//  SecondViewController.h
//  BooksStore
//
//  Created by meng ling on 11-11-3.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseUIScrollView.h"
#import "ASINetworkQueue.h"
#import "ReadController.h"
@interface SecondViewController : BaseViewController<MyBookDelegate>{
   
    BaseUIScrollView  *bScrollView;
    ASINetworkQueue *netWorkQueue;//创建一个队列
}
//@property (nonatomic,retain) NSNumber *choosedMagazineId;
@property (nonatomic, retain) IBOutlet BaseUIScrollView  *bScrollView;
-(Boolean)downBtnOfBookWasClicked:(MyBookView *)book;

@end
