//
//  MyOrderCell.h
//  CustomerOrder
//
//  Created by ios on 13-6-20.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCell : UITableViewCell
{
    UIImageView *_leftImgView;
    UILabel *_title;
    UILabel *_orderDate;

}

@property(retain,nonatomic)UIImageView *leftImgView;
@property(retain,nonatomic)UILabel *title;
@property(retain,nonatomic)UILabel *orderDate;


@end
