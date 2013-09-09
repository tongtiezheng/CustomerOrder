//
//  CheckNetwork.m
//  CustomerOrder
//
//  Created by ios on 13-7-19.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CheckNetwork.h"

@implementation CheckNetwork

+ (BOOL)isNetworkRunning
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];

    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络");
            return FALSE;
            break;
        case ReachableViaWWAN:
            NSLog(@"正在使用3G网络");
            return TRUE;
            break;
        case ReachableViaWiFi:
            NSLog(@"正在使用wifi网络");
            return TRUE;
            break;
    }

    return FALSE;
}


@end
