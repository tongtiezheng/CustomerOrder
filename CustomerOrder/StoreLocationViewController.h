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
@interface StoreLocationViewController : UIViewController<BMKMapViewDelegate,UIActionSheetDelegate>
{
    BMKMapView * _mapView;
   
    StoreList *_storeList;
    
    NSMutableArray *_availableMaps;
    
    BOOL _isSetMapSpan;
    CLLocationCoordinate2D _currentSelectCoordinate;
}

@property(retain,nonatomic)BMKMapView *mapView;
@property(retain,nonatomic)StoreList *storeList;

@property(retain,nonatomic)NSMutableArray *availableMaps;


@end
