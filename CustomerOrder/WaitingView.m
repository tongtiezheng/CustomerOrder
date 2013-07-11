//
//  WaitingView.m
//  WEBCARS_L
//
//  Created by mac on 13-2-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#define VIEW_X(a) a.frame.origin.x
#define VIEW_Y(a) a.frame.origin.y
#define VIEW_WIDTH(a)  a.frame.size.width
#define VIEW_HEIGHT(a)  a.frame.size.height

#import "WaitingView.h"

@implementation WaitingView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        waitingAIV = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(VIEW_WIDTH(self)/2-45, VIEW_HEIGHT(self)/2-10, 0,0)];
        waitingAIV.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:waitingAIV];
        [waitingAIV release];
        [waitingAIV startAnimating];
        
        waitingLabel = [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDTH(self)/2-30, VIEW_HEIGHT(self)/2-20, 90, 20)];
        waitingLabel.backgroundColor = [UIColor clearColor];
        waitingLabel.text = @"正在载入...";
        waitingLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:waitingLabel];
        [waitingLabel release];
    }
    return self;
}


//设置新位置
-(void)setNewposition:(CGRect)newFrame
{
    self.frame = newFrame;
    waitingAIV.frame = CGRectMake(VIEW_WIDTH(self)/2-45, VIEW_HEIGHT(self)/2-10, 0,0);
    waitingLabel.frame = CGRectMake(VIEW_WIDTH(self)/2-30, VIEW_HEIGHT(self)/2-20, 90, 20);
}

//启动等待视图
-(void)startWaiting
{
    if(self)
    {
        self.hidden = NO;
        [_delegate.view bringSubviewToFront:self];
    }
}
//撤销等待视图
-(void)stopWaiting
{
    if(self)
    {
        self.hidden = YES;
    }
}


-(void)dealloc
{
    waitingAIV = nil;
    waitingLabel = nil;
    [super dealloc];
}


@end
