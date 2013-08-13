//
//  DetailDisplayCell.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DetailDisplayCellDelegate;

@interface DetailDisplayCell : UITableViewCell
{
    UILabel *_title;
    UIImageView *_leftImgView;
    UIImageView *_gradeImgView;
    UILabel *_person;
    UILabel *_average;
    UITextView *_description;
    
    id <DetailDisplayCellDelegate> _delegate;
}

@property(retain,nonatomic)UILabel *title;
@property(retain,nonatomic)UIImageView *leftImgView;
@property(retain,nonatomic)UIImageView *gradeImgView;
@property(retain,nonatomic)UILabel *person;
@property(retain,nonatomic)UILabel *average;
@property(retain,nonatomic)UITextView *description;

@property(assign,nonatomic)id<DetailDisplayCellDelegate> delegate;


@end


@protocol DetailDisplayCellDelegate <NSObject>

@optional

- (void)selectLeftImgView:(DetailDisplayCell *)leftImgView;

@end
