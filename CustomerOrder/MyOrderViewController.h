//
//  MyOrderViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableView;
}

@property(retain,nonatomic)UITableView *myTableView;

@end
