//
//  NearbyViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
#import "PullingRefreshTableView.h"
@interface NearbyViewController : UIViewController<UITableViewDataSource,
                                                   UITableViewDelegate,
                                                   UISearchBarDelegate,
                                                   UISearchDisplayDelegate,
                                                   HTTPDownloadDelegate,
                                                   PullingRefreshTableViewDelegate>
{
    PullingRefreshTableView *_tableView;
    BOOL _refreshing;
    int  _curpage;
    
    UISearchDisplayController *_searchDidplay;
    UISearchBar *_searchBar;
    
    HTTPDownload *HD;
    NSMutableArray *_mArray;
    NSMutableArray *_resultArray;
    
    NSArray *_testArray;
    
}

@property(retain,nonatomic)PullingRefreshTableView *tableView;
@property(nonatomic) BOOL refreshing;
@property(assign,nonatomic)int curpage;

@property(retain,nonatomic)UISearchDisplayController *searchDidplay;
@property(retain,nonatomic)UISearchBar *searchBar;

@property(retain,nonatomic)NSMutableArray *mArray;
@property(retain,nonatomic)NSMutableArray *resultArray;
@property(retain,nonatomic)NSArray *testArray;


@end
