//
//  StoreList.h
//  CustomerOrder
//
//  Created by ios on 13-7-10.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreList : NSObject
{
    NSString *_id;//商铺ID
    NSString *_name;//商铺名称
    NSString *_py;//商铺名称拼音
    NSString *_pic;//商铺图片
    NSString *_grade;//商铺等级
    NSString *_avmoney;//人均消费
    NSString *_lat;//纬度
    NSString *_lng;//经度
    NSString *_description;//商铺介绍
    NSString *_address;//商铺地址
    NSString *_province;//商铺所属省份
    NSString *_city;//商铺所属城市
    NSString *_tel;//商铺联系电话
}

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *py;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *grade;
@property (nonatomic,copy) NSString *avmoney;
@property (nonatomic,copy) NSString *lat;
@property (nonatomic,copy) NSString *lng;
@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *provines;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *tel;



@end
