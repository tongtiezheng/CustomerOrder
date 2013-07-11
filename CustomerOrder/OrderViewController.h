//
//  OrderViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *rigntShareBtn;
    
    UITableView *_tableView;
    
    NSArray *_floorA;
    
    UIButton *seatBtn;//座位选择
    
    UIView *_seatView;//默认一楼视图
    UIView *_seatView2;//二楼视图
    UIView *_seatView3;//三楼视图
    UIView *_seatViewAll;//全部视图
    
    
}

@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSArray *floorA;

@property(retain,nonatomic)UIView *seatView;
@property(retain,nonatomic)UIView *seatView2;
@property(retain,nonatomic)UIView *seatView3;
@property(retain,nonatomic)UIView *seatViewAll;

@end
