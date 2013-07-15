//
//  StoreLocationViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@class StoreList;
@interface StoreLocationViewController : UIViewController<BMKMapViewDelegate>
{
    BMKMapView * _mapView;
   
    StoreList *_storeList;
}

@property(retain,nonatomic)BMKMapView *mapView;
@property(retain,nonatomic)StoreList *storeList;


@end
