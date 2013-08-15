//
//  CollectionViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-14.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "DetailViewController.h"
#import "MoreViewController.h"
#import "DataBase.h"
#import "StoreList.h"
#import "UIImageView+WebCache.h"
#import "SetColor.h"

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
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //增加右边删除按钮
    self.editButtonItem.title = @"编辑";
    self.editButtonItem.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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

#pragma mark 
#pragma mark -- Table view data source

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
    CollectionCell *cell = (CollectionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //选中cell时的颜色
    [[SetColor shareInstance]setCellBackgroundColor:cell];
    
    
    StoreList *info = [dataArray objectAtIndex:indexPath.row];
    cell.title.text = info.name;
    cell.average.text = info.avmoney;
    cell.description.text = info.description;
    [cell.leftImgView setImageWithURL:[NSURL URLWithString:info.pic] placeholderImage:[UIImage imageNamed:@"cellBg.png"]];
    cell.address.text = info.address;
    
//    NSString *strURL = [NSString stringWithFormat:@"%@",info.pic];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSData *imgData = [NSData dataWithContentsOfURL:url];
//    UIImage *img = [UIImage imageWithData:imgData];
//    cell.leftImgView.image = img;
    
    
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
 
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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

#pragma mark  
#pragma mark -- Table view delegate

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
    return 205.5f;
}


//实现删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger row = [indexPath row];
        //在数据库中删除记录
        [[DataBase defaultDataBase]deleteItem:[dataArray objectAtIndex:row]];
        
        //在获得的数组中删除记录
        //dataArray为当前tableView中显示的array
        [dataArray removeObjectAtIndex:row];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (self.editing) {
        
        self.editButtonItem.title = @"完成";
        
    } else {
        
        self.editButtonItem.title = @"编辑";
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
