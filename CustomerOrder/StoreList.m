//
//  StoreList.m
//  CustomerOrder
//
//  Created by ios on 13-7-10.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "StoreList.h"

@implementation StoreList
@synthesize id = _id;
@synthesize name = _name;
@synthesize py = _py;
@synthesize pic = _pic;
@synthesize grade = _grade;
@synthesize avmoney = _avmoney;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize description = _description;
@synthesize address = _address;
@synthesize provines = _province;
@synthesize city = _city;
@synthesize tel = _tel;

- (void)dealloc
{
    [_id release];
    [_name release];
    [_py release];
    [_pic release];
    [_grade release];
    [_avmoney release];
    [_lat release];
    [_lng release];
    [_description release];
    [_address release];
    [_province release];
    [_city release];
    [_tel release];
    
    [super dealloc];

}

@end