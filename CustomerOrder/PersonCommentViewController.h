//
//  PersonCommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
#import "StoreList.h"

@interface PersonCommentViewController : UIViewController<UITextViewDelegate,HTTPDownloadDelegate,UIAlertViewDelegate>
{
    UITextView *_txtView;
    UITextField *_mGrade;
    UITextField *_mAvmoney;
    
    UILabel *_fontCount;
    int count;
    
    HTTPDownload *HD;
    StoreList *_storeInfo;

}

@property(retain,nonatomic)UITextView *txtView;
@property(retain,nonatomic)UITextField *mGrade;
@property(retain,nonatomic)UITextField *mAvmoney;

@property(retain,nonatomic)UILabel *fontCount;

@property(retain,nonatomic)StoreList *storeInfo;

@end
