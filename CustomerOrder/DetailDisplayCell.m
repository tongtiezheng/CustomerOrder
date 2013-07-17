//
//  DetailDisplayCell.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "DetailDisplayCell.h"

@implementation DetailDisplayCell
@synthesize title = _title;
@synthesize leftImgView = _leftImgView;
@synthesize gradeImgView = _gradeImgView;
@synthesize person = _person;
@synthesize average = _average;
@synthesize description = _description;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 320, 30)];
        [self addSubview:_title];
        
        _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 100, 120)];
        [self addSubview:_leftImgView];
        
        _gradeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 35, 100, 20)];
        [self addSubview:_gradeImgView];
        
        _person = [[UILabel alloc]initWithFrame:CGRectMake(110, 60, 80, 20)];
        [_person setBackgroundColor:[UIColor clearColor]];
        [_person setText:@"人均：￥"];
        [self addSubview:_person];
        
        _average = [[UILabel alloc]initWithFrame:CGRectMake(180, 60, 40, 20)];
        [_average setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_average];
        
        _description = [[UITextView alloc]initWithFrame:CGRectMake(110, 80, WIDTH - 110, 80)];
        [_description setBackgroundColor:[UIColor clearColor]];
        _description.font = [UIFont systemFontOfSize:14];
        [_description setEditable:NO];
        [self addSubview:_description];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [_title release];
    [_leftImgView release];
    [_gradeImgView release];
    [_person release];
    [_average release];
    [_description release];
    
    [super dealloc];
}

@end
