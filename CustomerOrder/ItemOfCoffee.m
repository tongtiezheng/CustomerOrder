//
//  ItemOfCoffee.m
//  CustomerOrder
//
//  Created by ios on 13-6-17.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "ItemOfCoffee.h"

@implementation ItemOfCoffee
@synthesize storeID = _storeID;
@synthesize bigPicUrl = _bigPicUrl;
@synthesize picUrl = _picUrl;
@synthesize title = _title;
@synthesize description = _description;
@synthesize gradeDesc = _gradeDesc;
@synthesize avMoney = _avMoney;
@synthesize orderTel = _orderTel;
@synthesize address = _address;
@synthesize orderNum = _orderNum;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize cityID = _cityID;
@synthesize location = _location;
@synthesize districtID = _districtID;
@synthesize districtName = _districtName;
@synthesize streetID = _streetID;
@synthesize street = _street;


- (void)dealloc
{
    
    [_storeID release];
    [_bigPicUrl release];
    [_picUrl release];
    [_title release];
    [_description release];
    [_gradeDesc release];
    [_avMoney release];
    [_orderTel release];
    [_address release];
    [_orderNum release];
    [_latitude release];
    [_longitude release];
    [_cityID release];
    [_location release];
    [_districtID release];
    [_districtName release];
    [_storeID release];
    [_street release];
    
    [super dealloc];

}

@end
