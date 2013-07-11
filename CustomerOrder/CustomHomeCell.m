//
//  CustomHomeCell.m
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CustomHomeCell.h"

@implementation CustomHomeCell
@synthesize leftImgView = _leftImgView;
@synthesize gradeImgView = _gradeImgView;
@synthesize title = _title;
@synthesize person = _person;
@synthesize average = _average;
@synthesize address = _address;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        [self addSubview:_leftImgView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(85, 5,self.frame.size.width - 85, 20)];
        [self addSubview:_title];
        
        _gradeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(85, 30, 100, 20)];
        [self addSubview:_gradeImgView];
        
        _person = [[UILabel alloc]initWithFrame:CGRectMake(190, 30, 60, 20)];
        _person.text = @"人均:￥";
        [self addSubview:_person];
        
        _average = [[UILabel alloc]initWithFrame:CGRectMake(245, 30, 20, 20)];
        [_average setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_average];
    
        _address = [[UILabel alloc]initWithFrame:CGRectMake(85, 50, self.frame.size.width - 85, 30)];
        [_address setFont:[UIFont systemFontOfSize:10.0f]];
        _address.numberOfLines = 0;
        [self addSubview:_address];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    
    [_leftImgView release];
    [_gradeImgView release];
    [_title release];
    [_person release];
    [_average release];
    [_address release];
    
    [super dealloc];

}

@end
