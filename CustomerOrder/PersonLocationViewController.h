//
//  PersonLocationViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PersonLocationViewController : UIViewController<MKMapViewDelegate>
{
    //ios自带地图
    MKMapView *_mapView;
    
    BOOL _isSetMapSpan;
    
    CLLocationCoordinate2D _currentSelectCoordinate;
}


@property (retain,nonatomic)MKMapView *mapView;


@end
