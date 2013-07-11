//
//  MyOrderCell.m
//  CustomerOrder
//
//  Created by ios on 13-6-20.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell
@synthesize leftImgView = _leftImgView;
@synthesize title = _title;
@synthesize orderDate = _orderDate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 100, 90)];
        [self addSubview:_leftImgView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(110, 5, 100, 30)];
        [self addSubview:_title];
        
        _orderDate = [[UILabel alloc]initWithFrame:CGRectMake(220, 5, 100, 30)];
        [self addSubview:_orderDate];
        
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
    [_leftImgView release];
    [_title release];
    [_orderDate release];
    
    [super dealloc];

}

@end
