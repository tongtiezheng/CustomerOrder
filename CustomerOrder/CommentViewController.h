//
//  CommentViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPDownload.h"

@interface CommentViewController : UITableViewController<HTTPDownloadDelegate>
{
    HTTPDownload *HD;
}

@end
