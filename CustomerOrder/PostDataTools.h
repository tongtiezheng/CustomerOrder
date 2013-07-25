//
//  PostDataTools.h
//  CustomerOrder
//
//  Created by ios on 13-7-25.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostDataTools : NSObject

+ (NSString *)postDataWithPostArgument:(NSString *)argument andAPI:(NSString *)api;

@end
