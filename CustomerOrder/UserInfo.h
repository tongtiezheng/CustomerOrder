//
//  UserInfo.h
//  CustomerOrder
//
//  Created by ios on 13-7-24.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

//保存登录名和密码
+ (void)savaLoginNameAndPwdWithName:(NSString *)name andNameKey:(NSString *)nameKey pwd:(NSString *)pwd andPwdKey:(NSString *)pwdKey;

//移除登录名和密码
+ (void)removeLoginNameAndPwdWithNameKey:(NSString *)nameKey andPwdKey:(NSString *)pwdKey;


//保存登录结果
+ (void)savaOnline_keyValue:(NSString *)online_Value andKey:(NSString *)online_key;

//取得登录结果
+ (NSString *)getOnline_keyValueWithKey:(NSString *)online_key;

+ (void)removeOnline_keyValueWithKey:(NSString *)online_key;


@end
