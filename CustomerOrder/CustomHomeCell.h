//
//  CustomHomeCell.h
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHomeCell : UITableViewCell
{
    UIImageView *_leftImgView;
    UIImageView *_gradeImgView;
    
    UILabel *_title;
    UILabel *_person;
    UILabel *_average;
    UILabel *_address;
}


@property(retain,nonatomic)UIImageView *leftImgView;
@property(retain,nonatomic)UIImageView *gradeImgView;
@property(retain,nonatomic)UILabel *title;
@property(retain,nonatomic)UILabel *person;
@property(retain,nonatomic)UILabel *average;
@property(retain,nonatomic)UILabel *address;


@end
