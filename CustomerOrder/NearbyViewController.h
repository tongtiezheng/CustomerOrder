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
    
    HTTPDownload *HD;
    
    NSMutableArray *_mArray;
    
}

@property(retain,nonatomic)PullingRefreshTableView *tableView;
@property(nonatomic) BOOL refreshing;
@property(assign,nonatomic)int curpage;

@property(retain,nonatomic)UISearchDisplayController *searchDidplay;
@property(retain,nonatomic)NSMutableArray *mArray;



@end
