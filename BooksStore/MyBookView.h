//
//  MyBookView.h
//
//  Created by pubo on 11-5-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIProgressDelegate.h"
#import "BaseParamUtil.h"
@class MyBookView;
//书的代理
@protocol MyBookDelegate <NSObject>
 @optional
- (void)downBtnOfBookWasClicked:(MyBookView *)book;//下载
- (void)pauseBtnOfBookWasClicked:(MyBookView *)book;//暂停
- (void)readBtnOfBookWasClicked:(MyBookView *)book;//查看
- (void)deleteBtnOfBookWasClicked:(MyBookView *)book;//删除
@end


@interface MyBookView : UIView <ASIProgressDelegate>{

	id delegate;
	int bookID;//ID
	NSString *bookName;//book名字
	float contentLength;//书的大小(BIT)
	NSString *bookPath;//书的路径
	UIButton *downButton;//下载按键
	//UIButton *pauseButton;//暂停按键
	//UIButton *unZipButton;//解压按键
	UIButton *readButton;//阅读按键
	//UIButton *deleteButton;//删除按键
	UIProgressView *zztjProView;//系统的进度条
	//UIImageView *imageProView;//自己做的进度条VIEW
	//UIImageView *imageProBgView;//自己做的进度条VIEW背景
	UILabel *downText;//显示书的名字
	BOOL downloadCompleteStatus;//下载状态(是否已经下载完成)
    BOOL zipCompleteStatus;//下载状态(是否已经下载完成)
    
   // UIImage *image ;//杂志背景
    //UIImage *bgimage;//杂志背景
    UIImageView *iv;
    UIImageView *bgiv;
}
//@property(nonatomic ,retain)UIImage *image;
//@property(nonatomic ,retain)UIImage *bgimage;

@property(nonatomic ,retain)UIImageView *iv;
@property(nonatomic ,retain)UIImageView *bgiv;

@property (nonatomic,assign)id<MyBookDelegate> delegate;

@property (nonatomic,assign)int bookID;
@property(nonatomic ,retain)NSString *bookName;
@property (nonatomic,assign)float contentLength;
@property(nonatomic ,retain)NSString *bookPath;
@property(nonatomic ,retain)UIButton *downButton;
//@property(nonatomic ,retain)UIButton *pauseButton;
//@property(nonatomic ,retain)UIButton *unZipButton;
@property(nonatomic ,retain)UIButton *readButton;
//@property(nonatomic ,retain)UIButton *deleteButton;
@property(nonatomic ,retain)UIProgressView *zztjProView;
//@property(nonatomic ,retain)UIImageView *imageProView;
//@property(nonatomic ,retain)UIImageView *imageProBgView;
@property(nonatomic ,retain)UILabel *downText;
@property (nonatomic,assign)BOOL downloadCompleteStatus;
@property (nonatomic,assign)BOOL zipCompleteStatus;
- (void)downButtonClick;
@end
