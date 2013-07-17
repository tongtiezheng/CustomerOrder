//
//  DetailDisplayCell.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailDisplayCell : UITableViewCell
{
    UILabel *_title;
    UIImageView *_leftImgView;
    UIImageView *_gradeImgView;
    UILabel *_person;
    UILabel *_average;
    UITextView *_description;
}

@property(retain,nonatomic)UILabel *title;
@property(retain,nonatomic)UIImageView *leftImgView;
@property(retain,nonatomic)UIImageView *gradeImgView;
@property(retain,nonatomic)UILabel *person;
@property(retain,nonatomic)UILabel *average;
@property(retain,nonatomic)UITextView *description;


@end
