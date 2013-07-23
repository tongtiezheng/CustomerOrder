//
//  CacheData.h
//  CustomerOrder
//
//  Created by ios on 13-7-18.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheData : NSObject


+ (void) saveCache:(int)type andID:(int)_id andData:(NSData *)data;

+ (NSData *) getCache:(int)type andID:(int)_id;

+ (void)removeCacheDataWithType:(int)type andID:(int)_id;

@end
