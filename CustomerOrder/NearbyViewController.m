//
//  NearbyViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "NearbyViewController.h"
#import "CustomHomeCell.h"
#import "OrderViewController.h"
#import "DetailViewController.h"
#import "SetColor.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController
@synthesize tableView = _tableView;
@synthesize searchDidplay = _searchDidplay;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"附近商户";
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    [searchBar setFrame:CGRectMake(0, 0, 320, 44)];
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:searchBar];
    
    UISearchDisplayController *searchCon = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchCon.delegate = self;
    searchCon.searchResultsDelegate = self;
    searchCon.searchResultsDataSource = self;
    self.searchDidplay = searchCon;//UISearchDisplayController 必须定义成属性
    [searchCon release];
    [searchBar release];
    
    //自定义tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 49 - 44 - 20 - 44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark -- UISearchDisplayDelegate
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    

}



#pragma mark -- tableView dataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomHomeCell *cell = (CustomHomeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[CustomHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    //设置选中后cell的背景颜色
    SetColor *instance = [SetColor shareInstance];
    [instance setCellBackgroundColor:cell];
    
    cell.leftImgView.image = [UIImage imageNamed:@"2.jpg"];
    cell.title.text = @"店铺名称";
    cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20@2x.png"];
    cell.address.text = @"店铺地址";
    cell.average.text = @"40";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.bounds.size.width - 60, 5, 60, 20)];
    [btn setImage:[UIImage imageNamed:@"order.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(orderStore:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    return cell;
}

//进入预订页面
- (void)orderStore:(UIButton *)sender
{
    NSLog(@"预订");
    OrderViewController *order = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
    [order release];
    
}

#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
