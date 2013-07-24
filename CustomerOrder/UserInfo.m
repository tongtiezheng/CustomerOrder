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


@end
