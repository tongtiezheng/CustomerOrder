//
//  ItemOfCoffee.h
//  CustomerOrder
//
//  Created by ios on 13-6-17.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemOfCoffee : NSObject
{
    NSString *_storeID;
    NSString *_bigPicUrl;
    NSString *_picUrl;
    NSString *_title;
    NSString *_description;
    NSString *_gradeDesc;
    NSString *_avMoney;
    NSString *_orderTel;
    NSString *_address;
    NSString *_orderNum;
    
    NSString *_latitude;//店铺纬度
    NSString *_longitude;//店铺经度
    
    NSString *_cityID;
    NSString *_location;//城市名字
    NSString *_districtID;//地区编号
    NSString *_districtName;//地区名字
    NSString *_streetID;//街区编号
    NSString *_street;//街区名字
}

@property(retain,nonatomic)NSString *storeID;
@property(retain,nonatomic)NSString *bigPicUrl;
@property(retain,nonatomic)NSString *picUrl;
@property(retain,nonatomic)NSString *title;
@property(retain,nonatomic)NSString *description;
@property(retain,nonatomic)NSString *gradeDesc;
@property(retain,nonatomic)NSString *avMoney;
@property(retain,nonatomic)NSString *orderTel;
@property(retain,nonatomic)NSString *address;
@property(retain,nonatomic)NSString *orderNum;
@property(retain,nonatomic)NSString *latitude;
@property(retain,nonatomic)NSString *longitude;
@property(retain,nonatomic)NSString *cityID;
@property(retain,nonatomic)NSString *location;
@property(retain,nonatomic)NSString *districtID;
@property(retain,nonatomic)NSString *districtName;
@property(retain,nonatomic)NSString *streetID;
@property(retain,nonatomic)NSString *street;

@end
