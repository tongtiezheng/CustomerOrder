//
//  MainViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-13.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITabBarControllerDelegate>
{
    UIImageView *_img;
    UIImageView *_item1;
    UIImageView *_item2;
    UIImageView *_item3;
    UIImageView *_item4;
    UITabBarController *_tab;
}

@property(nonatomic,retain)UIImageView *item1;
@property(nonatomic,retain)UIImageView *item2;
@property(nonatomic,retain)UIImageView *item3;
@property(nonatomic,retain)UIImageView *item4;
@property(nonatomic,retain)UITabBarController *tab;


@end
