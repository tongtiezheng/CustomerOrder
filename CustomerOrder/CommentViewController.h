//
//  CommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"
#import "StoreList.h"

@interface CommentViewController : UITableViewController<HTTPDownloadDelegate>
{
    HTTPDownload *HD;
    StoreList *_storeInfo;
    
}

@property (retain,nonatomic)StoreList *storeInfo;

@end
