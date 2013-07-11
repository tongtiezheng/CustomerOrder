//
//  NYHAppDelegate.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "BMapKit.h"

#import "WXApi.h"
#import "AGViewDelegate.h"

@interface NYHAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    BMKMapManager* _mapManager;
    Reachability *_hostReach;
    
    enum WXScene _scene;
    AGViewDelegate *_viewDelegate;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) BMKMapManager *mapManager;
@property (retain, nonatomic) Reachability *hostReach;

@property (readonly,nonatomic) AGViewDelegate *viewDelegate;


@end
