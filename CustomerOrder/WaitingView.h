//
//  WaitingView.h
//  WEBCARS_L
//
//  Created by mac on 13-2-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingView : UIView
{
    UIActivityIndicatorView *waitingAIV;
    UILabel *waitingLabel;   
    UIViewController *_delegate;
}

@property(nonatomic,assign) UIViewController *delegate;


//设置新位置
-(void)setNewposition:(CGRect)newFrame;
//启动
-(void)startWaiting;
//停止
-(void)stopWaiting;

@end
