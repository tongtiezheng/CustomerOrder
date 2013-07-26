//
//  CommentList.m
//  CustomerOrder
//
//  Created by ios on 13-7-26.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CommentList.h"


@implementation CommentList
@synthesize avmoney = _avmoney;
@synthesize c_id = _c_id;
@synthesize content = _content;
@synthesize grade = _grade;
@synthesize publish = _publish;


- (void)dealloc
{
    [_avmoney release];
    [_c_id release];
    [_content release];
    [_grade release];
    [_publish release];
    
    [super dealloc];
}


@end
