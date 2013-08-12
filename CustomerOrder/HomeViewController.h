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

@interface HomeViewController : UIViewController <UITableViewDataSource,
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
    
    HTTPDownload *_HD;
    WaitingView *_waitView;//等待视图
    
    NSTimer *timer;//循环滚动计时器

    
	BOOL _loadingMore;//加载状态
    int curpage;//当前页数
    
    EGORefreshTableHeaderView *_refreshTableView;
    BOOL _reloading;
    
    MBProgressHUD *HUD;//进度指示轮
    int pro_ID; //省份ID
    
    int cacheID;//缓存类型ID
}

@property(retain,nonatomic)UITableView *customTV;
@property(retain,nonatomic)UISearchBar *search;
@property(retain,nonatomic)NSString *currentCity;
@property(retain,nonatomic)NSMutableArray *mArray;
@property(retain,nonatomic)EGORefreshTableHeaderView *refreshTableView;
@property(retain,nonatomic)HTTPDownload *HD;
@property(retain,nonatomic)WaitingView *waitView;


//开始重新加载时调用的方法
- (void)reloadTableViewDataSource;
//完成加载时调用的方法
- (void)doneLoadingTableViewData;


@end
