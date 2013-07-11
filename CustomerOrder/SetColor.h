//
//  SetColor.h
//  CustomerOrder
//
//  Created by ios on 13-7-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetColor : UIView


+ (SetColor *)shareInstance;

- (void)setCellBackgroundColor:(UITableViewCell *)cell;


@end
