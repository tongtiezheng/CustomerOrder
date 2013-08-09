//
//  NYHAppDelegate.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "AGViewDelegate.h"
#import <MapKit/MapKit.h>

@interface NYHAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    Reachability *_hostReach;
    
    enum WXScene _scene;
    AGViewDelegate *_viewDelegate;
    
    CLLocationManager *_locManager;
    
}

@property (strong, nonatomic)   UIWindow *window;
@property (retain, nonatomic)   Reachability *hostReach;
@property (readonly, nonatomic) AGViewDelegate *viewDelegate;

@property (retain, nonatomic)   CLLocationManager *locManager;


@end
