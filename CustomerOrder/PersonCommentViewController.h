//
//  PersonCommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
@class StoreList;

@interface PersonCommentViewController : UIViewController<UITextViewDelegate,HTTPDownloadDelegate,UIAlertViewDelegate>
{
    UITextView *_txtView;
    UITextField *_mAvmoney;
    
    UILabel *_fontCount;
    int count;
    
    HTTPDownload *HD;
    StoreList *_storeInfo;
    
    UIButton *imgBtn1;//等级选择按钮
    UIButton *imgBtn2;
    UIButton *imgBtn3;
    UIButton *imgBtn4;
    UIButton *imgBtn5;
    
    UIImage *imgNormal;//等级图片
    UIImage *imgPress;
    
    float grade; //等级
}

@property(retain,nonatomic)UITextView *txtView;
@property(retain,nonatomic)UITextField *mAvmoney;

@property(retain,nonatomic)UILabel *fontCount;

@property(retain,nonatomic)StoreList *storeInfo;

@end
