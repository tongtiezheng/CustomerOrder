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
@synthesize distance = _distance;

//@synthesize order = _order;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        [self addSubview:_leftImgView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(85, 5, 100, 20)];
        [self addSubview:_title];
        
        _gradeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(85, 30, 100, 20)];
        [self addSubview:_gradeImgView];
        
        _person = [[UILabel alloc]initWithFrame:CGRectMake(190, 30, 80, 20)];
        _person.text = @"人均：￥";
        [self addSubview:_person];
        
        _average = [[UILabel alloc]initWithFrame:CGRectMake(260, 30, 40, 20)];
        [self addSubview:_average];
    
        _address = [[UILabel alloc]initWithFrame:CGRectMake(85, 55, 180, 20)];
        [self addSubview:_address];
        
        _distance = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - 60, 55, 60, 20)];
        [self addSubview:_distance];
        
//        _order = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_order setFrame:CGRectMake(self.bounds.size.width - 80, 5, 80, 20)];
//        [self addSubview:_order];
        
        
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
    [_distance release];
    
//    [_order release];
    
    [super dealloc];

}

@end
