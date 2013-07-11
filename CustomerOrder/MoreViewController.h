//
//  MoreViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_array1;
    NSArray *_array2;
    NSArray *_sectionArray;

}

@property(retain,nonatomic)UITableView *tableView;

@property(retain,nonatomic)NSArray *array1;
@property(retain,nonatomic)NSArray *array2;
@property(retain,nonatomic)NSArray *sectionArray;

@end
