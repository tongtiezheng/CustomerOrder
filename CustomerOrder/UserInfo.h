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


@end
