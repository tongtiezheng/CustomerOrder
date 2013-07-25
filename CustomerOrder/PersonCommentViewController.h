//
//  PersonCommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
@interface PersonCommentViewController : UIViewController<UITextViewDelegate,HTTPDownloadDelegate>
{
    UITextView *_txtView;
    UITextField *_mGrade;
    UITextField *_mAvmoney;
    
    UILabel *_fontCount;
    int count;
    
    HTTPDownload *HD;

}

@property(retain,nonatomic)UITextView *txtView;
@property(retain,nonatomic)UITextField *mGrade;
@property(retain,nonatomic)UITextField *mAvmoney;

@property(retain,nonatomic)UILabel *fontCount;

@end
