//
//  DetailViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@class NYHAppDelegate;
@class StoreList;

@interface DetailViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIButton *rigntShareBtn;
    NSArray * _imgArray;
    NSArray * _othersArray;
    
    NYHAppDelegate *_appDelegate;
    StoreList *_storeInfo;
    
    NSString *_lat;
    NSString *_lng;

    
}

@property(retain,nonatomic)NSArray * imgArray;
@property(retain,nonatomic)NSArray * othersArray;

@property(retain,nonatomic)NYHAppDelegate *appDelegate;
@property(retain,nonatomic)StoreList *storeInfo;

@property(copy,nonatomic)NSString *lat;
@property(copy,nonatomic)NSString *lng;





@end
