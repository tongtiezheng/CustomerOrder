//
//  PersonLocationViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMapKit.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

//@interface PersonLocationViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate,CLLocationManagerDelegate>

@interface PersonLocationViewController : UIViewController<CLLocationManagerDelegate>
{
    
//    BMKMapView *_mapView;
//    BMKSearch *_search;
//
//    NSString *info;
//    NSString *cityName;
//    
//    float localLatitude;//纬度
//    float localLongitude;//经度
//    BOOL _isSetMapSpan;
//    CLLocationCoordinate2D _currentSelectCoordinate;
    
    //ios自带地图
    CLLocationManager *_locManager;
    
    MKMapView *_mapView;
    
}

//@property(retain,nonatomic)BMKMapView *mapView;
//@property(retain,nonatomic)BMKSearch *search;

@property (retain,nonatomic)CLLocationManager *locManager;
@property (retain,nonatomic)MKMapView *mapView;




@end
