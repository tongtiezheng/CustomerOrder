//
//  SelectCityViewController.h
//  CustomerOrder
//
//  Created by ios on 13-7-9.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaitingView;
@interface SelectCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *_cityTableView;
    
    UISearchBar *_searchBar;

    NSMutableArray *_mArray;
    NSMutableData *_mData;
    
    NSMutableOrderedSet *_cityKeys;
    NSMutableDictionary *_cityList;
    
    NSString *_selectCity;
    WaitingView *waitingView;
    
}

@property (retain,nonatomic) UITableView *cityTableView;

@property (retain,nonatomic)UISearchBar *searchBar;


@property (retain,nonatomic) NSMutableArray *mArray;
@property (retain,nonatomic) NSMutableData *mData;
@property (retain,nonatomic) NSMutableArray *headTitleArray;
@property (retain,nonatomic) NSMutableOrderedSet *cityKeys;
@property (retain,nonatomic) NSMutableDictionary *cityList;

@property (copy,nonatomic) NSString *selectCity;

@end
