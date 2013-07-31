//
//  NearbyViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
#import "BMKMapView.h"

@interface NearbyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,HTTPDownloadDelegate>
{
    UITableView *_tableView;
    UISearchDisplayController *_searchDidplay;
    
    HTTPDownload *HD;
    
    NSMutableArray *_mArray;
    
    BMKMapView *_mapView;
}

@property(retain,nonatomic)UITableView *tableView;

@property(retain,nonatomic)UISearchDisplayController *searchDidplay;

@property(retain,nonatomic)NSMutableArray *mArray;
@property(retain,nonatomic)BMKMapView *mapView;


@end
