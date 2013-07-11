//
//  PersonCommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCommentViewController : UIViewController<UITextViewDelegate>
{
    UITextView *_txtView;
    UILabel *_fontCount;
    int count;

}

@property(retain,nonatomic)UITextView *txtView;
@property(retain,nonatomic)UILabel *fontCount;

@end
