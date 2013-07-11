//
//  StoreLocationViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface StoreLocationViewController : UIViewController<BMKMapViewDelegate>
{
    BMKMapView * _mapView;
   

}

@property(retain,nonatomic)BMKMapView *mapView;

@end
