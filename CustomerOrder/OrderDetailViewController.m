//
//  OrderDetailViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-14.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "OrderDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OrderViewController.h"
@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"预定时间";
    self.view.backgroundColor = [UIColor orangeColor];
    
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    
    //时间选取器
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    datePicker.locale = [NSLocale autoupdatingCurrentLocale];//设置ios中DatePicker的日期为中文格式
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    datePicker.date = [NSDate date];
    
    
    [self.view addSubview:datePicker];
    [datePicker release];
    
    
    //提交按钮
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commitBtn setFrame:CGRectMake(60, 240, 200, 40)];
    [commitBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [commitBtn setBackgroundImage:[UIImage imageNamed:@"Button_0_D.png"] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(makeSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];

}

//导航栏返回按钮
- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

//日期选择
-(void)dateChanged:(id)sender
{
    UIDatePicker * control = (UIDatePicker *)sender;
    NSDate * _date = control.date;
    
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY年MM月dd日 hh:mm:ss"];
    NSString * date = [formatter stringFromDate:_date];
    [formatter release];
    
    NSLog(@"%@",date);
    
    showDate = [[NSString alloc]initWithFormat:@"%@",date];
}

//弹出确认预定时间提示框
- (void)makeSure:(id)sender
{
    if (showDate.length == 0)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY年MM月dd日 hh:mm:ss"];
        NSString *cDate = [formatter stringFromDate:[NSDate date]];

        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"你预订的日期如下" message:cDate delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [formatter release];
        
        [alert1 show];
        
        [alert1 release];
        
    } else {
        
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"你预订的日期如下" message:showDate delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert2 show];
        [alert2 release];
           
    }
}

#pragma mark -- UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
            
        case 1:
        {
            view = [[[UIView alloc]initWithFrame:CGRectMake(20, 100, 280, 180)]autorelease];;
            [view setBackgroundColor:[UIColor blackColor]];
            [view setAlpha:0.8];
            [view.layer setCornerRadius:20.0f];
            [self.view addSubview:view];
            
            
            UILabel *label1 = [[UILabel alloc]init];
            [label1 setFrame:CGRectMake(view.center.x/2, -75, 220, 200)];
            label1.text = @"预定成功";
            label1.textColor = [UIColor orangeColor];
            label1.font = [UIFont systemFontOfSize:28.0f];
            label1.backgroundColor = [UIColor clearColor];
            [view addSubview:label1];
            [label1 release];

            
            UILabel *label2 = [[UILabel alloc]init];
            [label2 setFrame:CGRectMake(40, -15, 220, 200)];
            label2.text = @"您的预订将会在您选择的预订时间之后15分钟自动取消！";
            label2.textColor = [UIColor orangeColor];
            label2.font = [UIFont systemFontOfSize:20.0f];
            label2.numberOfLines = 0;
            label2.backgroundColor = [UIColor clearColor];
            [view addSubview:label2];
            [label2 release];

    
            UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [ensureBtn setFrame:CGRectMake(40, 130, 80, 40)];
            [ensureBtn setTitle:@"继续预订" forState:UIControlStateNormal];
            [ensureBtn addTarget:self action:@selector(continueOrder) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:ensureBtn];
            
            
            UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cancelBtn setFrame:CGRectMake(170, 130, 80, 40)];
            [cancelBtn setTitle:@"取消预订" forState:UIControlStateNormal];
            [cancelBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:cancelBtn];
        }
            
            break;
            
        default:
            break;
    }

}

//继续预定方法
- (void)continueOrder
{
     [self.navigationController popViewControllerAnimated:YES];
}

//取消预定
- (void)cancelOrder
{
    [view removeFromSuperview];
}

-(void)dealloc
{
    [showDate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
