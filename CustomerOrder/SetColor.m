//
//  SetColor.m
//  CustomerOrder
//
//  Created by ios on 13-7-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "SetColor.h"

@implementation SetColor

static SetColor *instance = nil;


//设置选中后cell的背景颜色
+ (SetColor *)shareInstance
{
   
    @synchronized(self)
    {
        if (instance == nil) {
            
            instance = [[[self class]alloc]init];
        }
    }
    
    return instance;
}


- (void)setCellBackgroundColor:(UITableViewCell *)cell
{
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    aView.backgroundColor = [UIColor orangeColor];
    cell.selectedBackgroundView = aView;
    [aView release];
    
}


+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        
        if (instance == nil)
        {
            instance = [super allocWithZone:zone];
        }
        
    }
    return instance;
}


- (id)copyWithZone:(NSZone *)zone
{
    return instance;
    //    return self;
    
}


- (id)retain
{
    return instance;
}
- (oneway void)release
{
    
}
- (id)autorelease
{
    return instance;
}
- (NSUInteger)retainCount
{
    return UINT_MAX;
}

@end
