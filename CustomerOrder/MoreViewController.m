//
//  MoreViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "MoreViewController.h"

#import "LoginViewController.h"
#import "AboutViewController.h"
#import "CollectionViewController.h"
#import "SetColor.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

@synthesize tableView = _tableView;

@synthesize array1 = _array1;
@synthesize array2 = _array2;
@synthesize sectionArray = _sectionArray;

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.title = @"更多";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _array1 = [[NSArray alloc]initWithObjects:@"登录",@"我的收藏",@"应用推荐", nil];
    
    _array2 = [[NSArray alloc]initWithObjects:@"清除缓存",@"关于我们", nil];
    
    _sectionArray = [[NSArray alloc]initWithObjects:_array1,_array2, nil];
    
    
}

#pragma mark -- tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_sectionArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
         cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
    //设置选中后cell的背景颜色
    SetColor *instance = [SetColor shareInstance];
    [instance setCellBackgroundColor:cell];
    
    
    cell.textLabel.text = [[_sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *loginNa = [[UINavigationController alloc]initWithRootViewController:login];
        loginNa.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:loginNa animated:YES completion:nil];
        [login release];
        [loginNa release];
    } else if((indexPath.section == 0) && (indexPath.row == 1)) {
        
        CollectionViewController *collection = [[CollectionViewController alloc]init];
        [self.navigationController pushViewController:collection animated:YES];
        [collection release];
    
    } if ((indexPath.section == 1)&&(indexPath.row == 1)) {
        
        AboutViewController *about = [[AboutViewController alloc]init];
        about.title = @"关于我们";
        [self.navigationController pushViewController:about animated:YES];
        [about release];
    }
}


//配置section之间的距离

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    view.backgroundColor = [UIColor clearColor];
    return [view autorelease];
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor clearColor];
    return [view autorelease];
}

- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
