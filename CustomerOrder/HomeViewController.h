//
//  HomeViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
#import "EGORefreshTableHeaderView.h"
@class WaitingView;
@interface HomeViewController : UIViewController<UITableViewDataSource,
                                                   UITableViewDelegate,
                                                   UISearchBarDelegate,
                                                   UIAlertViewDelegate,
                                                  HTTPDownloadDelegate,
                                         EGORefreshTableHeaderDelegate>
{
    UITableView * _customTV;
    UISearchBar * _search;
    
    NSString *_currentCity;
    
    UIButton *cityBtn;
    
    NSMutableArray *_mArray;
    HTTPDownload *HD;
    WaitingView *waitView;
    
    NSInteger curpage;//当前页码
    EGORefreshTableHeaderView *refreshView;//下拉刷新
    BOOL isLoading;//是否正在刷新

}

@property(retain,nonatomic)UITableView *customTV;
@property(retain,nonatomic)UISearchBar *search;

@property(retain,nonatomic)NSString *currentCity;
@property(retain,nonatomic)NSMutableArray *mArray;

//下拉刷新方法
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
