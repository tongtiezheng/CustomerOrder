//
//  HomeViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"

@interface HomeViewController : UIViewController<UITableViewDataSource,
                                                   UITableViewDelegate,
                                                   UISearchBarDelegate,
                                                   UIAlertViewDelegate,
                                                  HTTPDownloadDelegate>
{
    UITableView * _customTV;
    UISearchBar * _search;
    
    
    NSString *_currentCity;
    
    UIButton *cityBtn;
    
    NSMutableArray *_mArray;
    HTTPDownload *HD;
}

@property(retain,nonatomic)UITableView *customTV;
@property(retain,nonatomic)UISearchBar *search;


@property(retain,nonatomic)NSString *currentCity;


@property(retain,nonatomic)NSMutableArray *mArray;



@end
