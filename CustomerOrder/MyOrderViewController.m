//
//  MyOrderViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderCell.h"
#import "CONST.h"
@interface MyOrderViewController ()

@end

@implementation MyOrderViewController
@synthesize myTableView = _myTableView;

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
    self.title = @"我的预订";
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 20 - 44 - 49)];
    tv.delegate = self;
    tv.dataSource = self;
    self.myTableView = tv;
    [self.view addSubview:tv];
    [tv release];
}

#pragma mark -- tableView dataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    MyOrderCell *cell = (MyOrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    cell.leftImgView.image = [UIImage imageNamed:@"3.jpg"];
    cell.title.text = @"辉煌咖啡厅";
    cell.orderDate.text = @"2013-06-28";
    if (indexPath.row == 0) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn1 setFrame:CGRectMake(120, 40, 100, 40)];
        [btn1 setTitle:@"已预订" forState:UIControlStateNormal];
        [btn1 setBackgroundColor:[UIColor orangeColor]];
        [cell.contentView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn2 setFrame:CGRectMake(230, 40, 80, 40)];
        [btn2 setTitle:@"取消预订" forState:UIControlStateNormal];
        [btn2 setBackgroundColor:[UIColor orangeColor]];
        [cell.contentView addSubview:btn2];
    }
    
    if (indexPath.row == 1) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn1 setFrame:CGRectMake(120, 40, 100, 40)];
        [btn1 setTitle:@"预订已失效" forState:UIControlStateNormal];
        [btn1 setBackgroundColor:[UIColor orangeColor]];
        [cell.contentView addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn2 setFrame:CGRectMake(230, 40, 80, 40)];
        [btn2 setTitle:@"重新预订" forState:UIControlStateNormal];
        [btn2 setBackgroundColor:[UIColor orangeColor]];
        [cell.contentView addSubview:btn2];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}

#pragma mark -- tableView delegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;

}


-(void)dealloc
{
    [_myTableView release];
    
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
