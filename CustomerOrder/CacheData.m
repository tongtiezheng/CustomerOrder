//
//  CacheData.m
//  CustomerOrder
//
//  Created by ios on 13-7-18.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CacheData.h"

@implementation CacheData

+ (void)saveCache:(int)type andID:(int)_id andString:(NSString *)str
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",type,_id];
    [setting setObject:str forKey:key];
    [setting synchronize];
}


+ (NSString *)getCache:(int)type andID:(int)_id
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"detail-%d-%d",type, _id];
    
    NSString *value = [settings objectForKey:key];
    
    return value;
}

@end
