//
//  OrderCell.h
//  CustomerOrder
//
//  Created by ios on 13-6-9.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
{
    UIImageView *_leftImgView;
    UILabel *_title;
    UILabel *_description;
}
@property(retain,nonatomic)UIImageView *leftImgView;
@property(retain,nonatomic)UILabel *title;
@property(retain,nonatomic)UILabel *description;

@end
