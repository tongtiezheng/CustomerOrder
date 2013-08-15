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
    
    UIImageView *_imgView;

}

@property(retain,nonatomic)StoreList *storeList;

@property(retain,nonatomic)UIImageView *imgView;

@end
