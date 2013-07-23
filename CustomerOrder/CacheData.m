//
//  CacheData.m
//  CustomerOrder
//
//  Created by ios on 13-7-18.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CacheData.h"

@implementation CacheData

+ (void)saveCache:(int)type andID:(int)_id andData:(NSData *)data
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",type,_id];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];//同步存储到磁盘中
}


+ (NSData *)getCache:(int)type andID:(int)_id
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",type, _id];
    NSData *value = [settings dataForKey:key];
    
    return value;
}


+ (void)removeCacheDataWithType:(int)type andID:(int)_id
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",type, _id];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

@end
