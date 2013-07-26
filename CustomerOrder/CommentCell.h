//
//  CommentCell.h
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
{
    UILabel *_title;
    UIImageView *_pGrade;//个人等级
    UIImageView *_sGrade;//店铺等级
    UILabel *_person;
    UILabel *_average;
    
    UILabel *_content;
    
    UILabel *_date;

}

@property(retain,nonatomic)UILabel *title;
@property(retain,nonatomic)UIImageView *pGrade;
@property(retain,nonatomic)UIImageView *sGrade;
@property(retain,nonatomic)UILabel *person;
@property(retain,nonatomic)UILabel *average;
@property(retain,nonatomic)UILabel *content;
@property(retain,nonatomic)UILabel *date;

@end
