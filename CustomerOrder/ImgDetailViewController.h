//
//  ImgDetailViewController.h
//  CustomerOrder
//
//  Created by ios on 13-8-13.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreList;

@interface ImgDetailViewController : UIViewController
{
    StoreList *_storeList;

}

@property(retain,nonatomic)StoreList *storeList;

@end
