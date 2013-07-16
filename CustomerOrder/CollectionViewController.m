//
//  CollectionViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-14.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CollectionViewController.h"
#import "DetailDisplayCell.h"
#import "DetailViewController.h"
#import "MoreViewController.h"
#import "DataBase.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];


    //获取数据库数据
    dataArray = [[[DataBase defaultDataBase]selectStoreSItemsFromDataBase]retain];
    NSLog(@"**dataArray**%@",dataArray);
    
}

- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailDisplayCell *cell = (DetailDisplayCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DetailDisplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.leftImgView.image = [UIImage imageNamed:@"2.jpg"];
    cell.title.text = @"华信咖啡厅";
    cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20@2x.png"];
    cell.average.text = @"81";
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.5f;

}

@end
