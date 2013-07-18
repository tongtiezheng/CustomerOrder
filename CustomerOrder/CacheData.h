//
//  CacheData.h
//  CustomerOrder
//
//  Created by ios on 13-7-18.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheData : NSObject

+ (void) saveCache:(int)type andID:(int)_id andString:(NSString *)str;

+ (NSString *) getCache:(int)type andID:(int)_id;

@end
