//
//  CityName.h
//  CustomerOrder
//
//  Created by ios on 13-6-17.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityName : NSObject
{
    NSMutableString *_name;
    NSString *_py;
    NSString *_cityid;

}

@property(nonatomic,copy)NSMutableString *name;
@property(nonatomic,copy)NSString *py;
@property(nonatomic,copy)NSString *cityid;

@end
