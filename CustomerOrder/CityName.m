//
//  CityName.m
//  CustomerOrder
//
//  Created by ios on 13-6-17.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CityName.h"

@implementation CityName
@synthesize name = _name;
@synthesize py = _py;
@synthesize cityid = _cityid;

- (void)dealloc
{
    [_name release];
    [_py release];
    [_cityid release];

    [super dealloc];
}
@end
