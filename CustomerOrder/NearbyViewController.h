//
//  NearbyViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *_tableView;
    UISearchDisplayController *_searchDidplay;
    
   

}

@property(retain,nonatomic)UITableView *tableView;

@property(retain,nonatomic)UISearchDisplayController *searchDidplay;



@end
