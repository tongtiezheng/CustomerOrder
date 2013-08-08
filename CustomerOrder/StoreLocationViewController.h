//
//  StoreLocationViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@class StoreList;

@interface StoreLocationViewController : UIViewController<UIActionSheetDelegate,MKMapViewDelegate>
{
    MKMapView *_mapView;
   
    StoreList *_storeList;
    
    NSMutableArray *_availableMaps;
   
}


@property(retain,nonatomic)MKMapView *mapView;
@property(retain,nonatomic)StoreList *storeList;

@property(retain,nonatomic)NSMutableArray *availableMaps;


@end
