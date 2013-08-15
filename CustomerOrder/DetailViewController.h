//
//  DetailViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import "HTTPDownload.h"

@class NYHAppDelegate,StoreList;

@interface DetailViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate,HTTPDownloadDelegate>
{
    UIButton *rigntShareBtn;
    NSArray * _imgArray;
    NSArray * _othersArray;
    
    NYHAppDelegate *_appDelegate;
    StoreList *_storeInfo;
    
    NSString *_lat;
    NSString *_lng;
    
    HTTPDownload *_HD;
    int _curpage;
    NSMutableArray *_mArray;

    
}

@property(retain,nonatomic)NSArray * imgArray;
@property(retain,nonatomic)NSArray * othersArray;

@property(retain,nonatomic)NYHAppDelegate *appDelegate;
@property(retain,nonatomic)StoreList *storeInfo;
@property(retain,nonatomic)HTTPDownload *HD;
@property(assign,nonatomic)int curpage;
@property(retain,nonatomic)NSMutableArray *mArray;

@property(copy,nonatomic)NSString *lat;
@property(copy,nonatomic)NSString *lng;





@end
