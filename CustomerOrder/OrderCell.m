//
//  OrderCell.m
//  CustomerOrder
//
//  Created by ios on 13-6-9.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

@synthesize leftImgView = _leftImgView;
@synthesize title = _title;
@synthesize description = _description;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 140, 90)];
        [self addSubview:_leftImgView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(145, 5, self.frame.size.width - 145, 30)];
        _title.textColor = [UIColor orangeColor];
        [self addSubview:_title];
        
        _description = [[UILabel alloc]initWithFrame:CGRectMake(145, 35, self.frame.size.width - 145, 60)];
        _description.font = [UIFont systemFontOfSize:10.0f];
        _description.numberOfLines = 0;
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
    [_leftImgView release];
    [_title release];
    [_description release];
    [super dealloc];
}
@end
