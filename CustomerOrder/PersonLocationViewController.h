//
//  PersonLocationViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface PersonLocationViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate>
{
    BMKMapView *_mapView;
    BMKSearch *_search;

    NSString *info;
    NSString *cityName;
    
    float localLatitude;//纬度
    float localLongitude;//经度
    BOOL _isSetMapSpan;
    CLLocationCoordinate2D _currentSelectCoordinate;
}

@property(retain,nonatomic)BMKMapView *mapView;
@property(retain,nonatomic)BMKSearch *search;

@end
