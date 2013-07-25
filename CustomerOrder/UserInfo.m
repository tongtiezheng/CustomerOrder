//
//  UserInfo.m
//  CustomerOrder
//
//  Created by ios on 13-7-24.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


//保存登录名和密码
+ (void)savaLoginNameAndPwdWithName:(NSString *)name andNameKey:(NSString *)nameKey pwd:(NSString *)pwd andPwdKey:(NSString *)pwdKey
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:name forKey:nameKey];
    [userInfo setObject:pwd forKey:pwdKey];
    [userInfo synchronize];
    
}

//移除登录名和密码
+ (void)removeLoginNameAndPwdWithNameKey:(NSString *)nameKey andPwdKey:(NSString *)pwdKey
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo removeObjectForKey:nameKey];
    [userInfo removeObjectForKey:pwdKey];
    [userInfo synchronize];
}

//
+ (void)savaOnline_keyValue:(NSString *)online_Value andKey:(NSString *)online_key
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:online_Value forKey:online_key];
    [user synchronize];
}

//
+ (NSString *)getOnline_keyValueWithKey:(NSString *)online_key
{
    NSUserDefaults *getKey = [NSUserDefaults standardUserDefaults];
    NSString *value = [getKey objectForKey:online_key];
    [getKey synchronize];
    return value;
}

+ (void)removeOnline_keyValueWithKey:(NSString *)online_key
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo removeObjectForKey:online_key];
    [userInfo synchronize];
}

@end
