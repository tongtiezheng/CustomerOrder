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
#import "StoreList.h"


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
    dataArray = [[[DataBase defaultDataBase]selectStoresItemsFromDataBase]retain];
//    NSLog(@"**dataArray**%@",dataArray);
    
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
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailDisplayCell *cell = (DetailDisplayCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DetailDisplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    StoreList *info = [dataArray objectAtIndex:indexPath.row];
    cell.title.text = info.name;
    cell.average.text = info.avmoney;
    cell.description.text = info.description;
    
    NSString *strURL = [NSString stringWithFormat:@"%@",info.pic];
    NSURL *url = [NSURL URLWithString:strURL];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:imgData];
    cell.leftImgView.image = img;
    
    float selectGrade = [info.grade floatValue];
    if (selectGrade == 0) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar0.png"];
    }else if (selectGrade == 1) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar10.png"];
        
    } else if (selectGrade == 2) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20.png"];
        
    }else if (selectGrade == 2.5) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar25.png"];
        
    }else if (selectGrade == 3) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar30.png"];
        
    }else if (selectGrade == 3.5) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar35.png"];
        
    }else if (selectGrade == 4) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar40.png"];
        
    }else if (selectGrade == 4.5) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar45.png"];
        
    }else if (selectGrade == 5) {
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar50.png"];
    }
 
    return cell;
}


-(void)viewWillAppear:(BOOL)animated
{
    //获取数据库数据
    dataArray = [[[DataBase defaultDataBase]selectStoresItemsFromDataBase]retain];
    if(dataArray.count == 0)
    {
        self.tableView.hidden = YES;
        return;
    }
    [self.tableView reloadData];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    StoreList *storeInfo = [dataArray objectAtIndex:indexPath.row];
    detail.storeInfo = storeInfo;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.5f;
}

@end
