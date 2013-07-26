//
//  CommentList.h
//  CustomerOrder
//
//  Created by ios on 13-7-26.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentList : NSObject
{
    NSString *_avmoney;
    NSString *_c_id;
    NSString *_content;
    NSString *_grade;
    NSString *_publish;

}


@property(nonatomic,copy)NSString *avmoney;
@property(nonatomic,copy)NSString *c_id;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *grade;
@property(nonatomic,copy)NSString *publish;


@end
