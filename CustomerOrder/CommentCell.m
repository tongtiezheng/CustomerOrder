//
//  CommentCell.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell
@synthesize title = _title;
@synthesize pGrade = _pGrade;
@synthesize sGrade = _sGrade;
@synthesize person = _person;
@synthesize content = _content;
@synthesize date = _date;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 120, 20)];
        [self addSubview:_title];
        
        _pGrade = [[UIImageView alloc]initWithFrame:CGRectMake(125, 5, 60, 15)];
        [self addSubview:_pGrade];
        
        _sGrade = [[UIImageView alloc]initWithFrame:CGRectMake(5, 25, 80, 15)];
        [self addSubview:_sGrade];
        
        _person = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 60, 20)];
        [_person setText:@"人均：￥"];
        [_person setFont:[UIFont systemFontOfSize:12.0]];
        [_person setBackgroundColor:[UIColor clearColor]];
        [_person setTextColor:[UIColor grayColor]];
        [self addSubview:_person];
    
        _average = [[UILabel alloc]initWithFrame:CGRectMake(170, 25, 80, 20)];
        [_average setFont:[UIFont systemFontOfSize:12.0]];
        [_average setTextColor:[UIColor grayColor]];
        [self addSubview:_average];
        
        _content = [[UILabel alloc]initWithFrame:CGRectMake(5, 45, 310, 30)];
        _content.numberOfLines = 0;
        [_content setFont:[UIFont systemFontOfSize:12.0]];
        [self addSubview:_content];
        
        _date = [[UILabel alloc]initWithFrame:CGRectMake(5, 85, 100, 10)];
        [_date setBackgroundColor:[UIColor clearColor]];
        [_date setFont:[UIFont systemFontOfSize:10.0]];
        [_date setTextColor:[UIColor grayColor]];
        [self addSubview:_date];
        
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
    [_pGrade release];
    [_sGrade release];
    [_person release];
    [_average release];
    [_content release];
    [_date release];
    
    [super dealloc];
    
}
@end
