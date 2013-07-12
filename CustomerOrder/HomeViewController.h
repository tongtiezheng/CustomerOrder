//
//  HomeViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"
@class WaitingView;

@interface HomeViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UIAlertViewDelegate,
HTTPDownloadDelegate,
MBProgressHUDDelegate,
EGORefreshTableHeaderDelegate>

{
    UITableView * _customTV;
    UISearchBar * _search;
    
    NSString *_currentCity;

    UIButton *cityBtn;
    NSMutableArray *_mArray;
    
    HTTPDownload *HD;
    WaitingView *waitView;
    
    // 加载状态
	BOOL _loadingMore;
    int curpage;
    
    EGORefreshTableHeaderView *_refreshTableView;
    BOOL _reloading;
    
    MBProgressHUD *HUD;    
}

@property(retain,nonatomic)UITableView *customTV;
@property(retain,nonatomic)UISearchBar *search;
@property(retain,nonatomic)NSString *currentCity;
@property(retain,nonatomic)NSMutableArray *mArray;


//开始重新加载时调用的方法
- (void)reloadTableViewDataSource;
//完成加载时调用的方法
- (void)doneLoadingTableViewData;

@end
