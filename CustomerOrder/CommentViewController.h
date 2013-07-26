//
//  CommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-7-26.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "StoreList.h"
#import "HTTPDownload.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,HTTPDownloadDelegate>
{
    
    PullingRefreshTableView *_tableView;
    
    NSMutableArray *_mArray;
    StoreList *_storeInfo;
    
    HTTPDownload *HD;
    int _curpage;
    
    BOOL _refreshing;
}

@property (retain,nonatomic)PullingRefreshTableView *tableView;
@property (retain,nonatomic)NSMutableArray *mArray;

@property (retain,nonatomic)StoreList *storeInfo;

@property (nonatomic) BOOL refreshing;

@property (assign,nonatomic) int curpage;


@end
