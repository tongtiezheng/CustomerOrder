//
//  DetailViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "ItemOfCoffee.h"

#import <ShareSDK/ShareSDK.h>
@class NYHAppDelegate;

@interface DetailViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIButton *rigntShareBtn;
    NSArray * _imgArray;
    NSArray * _othersArray;
   
    FMDatabase *db;
    ItemOfCoffee *_itemForDataBase;
    
    NYHAppDelegate *_appDelegate;
    
}

@property(retain,nonatomic)NSArray * imgArray;
@property(retain,nonatomic)NSArray * othersArray;

@property(assign,nonatomic)ItemOfCoffee *itemForDataBase;

@property(retain,nonatomic)NYHAppDelegate *appDelegate;


@end
