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
#import "PersonalCenterViewController.h"
#import "CollectionViewController.h"
#import "SetColor.h"
#import "CacheData.h"
#import "UserInfo.h"

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

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.title = @"更多";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //退出登录按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"Exit_Account.png"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtn setShowsTouchWhenHighlighted:YES];
    [rightBtn addTarget:self action:@selector(cancelLogin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
   
    
}


- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _username = [userDefaults objectForKey:@"username"];
    _pwd = [userDefaults objectForKey:@"pwd"];
    
    NSLog(@"--------_username------%@",_username);
    
    if (_username != nil && _pwd != nil) {
        
        _array1 = [[NSArray alloc]initWithObjects:@"已登录/个人中心",@"我的收藏",@"应用推荐", nil];
        
    } else {
        
        _array1 = [[NSArray alloc]initWithObjects:@"登录",@"我的收藏",@"应用推荐", nil];
    }
    
    _array2 = [[NSArray alloc]initWithObjects:@"清除缓存",@"关于我们", nil];
    
    //分区数组
    _sectionArray = [[NSArray alloc]initWithObjects:_array1,_array2, nil];
    
    
    [self.tableView reloadData];

}

//退出登录
- (void)cancelLogin
{
     if (_username != nil && _pwd != nil) {
         
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
     
     } else {
         
         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
         [alertView show];
         [alertView release];
         
     }
}

#pragma mark 
#pragma mark -- alertView delegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
            
            if (_username != nil && _pwd != nil) {
                
                [UserInfo removeLoginNameAndPwdWithNameKey:@"username" andPwdKey:@"pwd"];
                [UserInfo removeOnline_keyValueWithKey:@"online_key"];
                [self viewWillAppear:YES];
            
            } else {
                
                LoginViewController *login = [[LoginViewController alloc]init];
                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:login];
                
                [self presentViewController:navi animated:YES completion:nil];
                
                [login release];
                [navi release];
            }
            
            break;
            
        default:
            break;
    }
}

#pragma mark 
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
        
        if (_username != nil && _pwd != nil) {
            
            PersonalCenterViewController *pCenter = [[PersonalCenterViewController alloc]init];
            pCenter.title = @"个人中心";
            [self.navigationController pushViewController:pCenter animated:YES];
            [pCenter release];
            
        } else {
            
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *loginNa = [[UINavigationController alloc]initWithRootViewController:login];
        loginNa.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:loginNa animated:YES completion:nil];
        [login release];
        [loginNa release];
            
        }
        
    } else if((indexPath.section == 0) && (indexPath.row == 1)) {
        
        CollectionViewController *collection = [[CollectionViewController alloc]init];
        [self.navigationController pushViewController:collection animated:YES];
        [collection release];
    
    } else if ((indexPath.section == 1)&&(indexPath.row == 0)) {
        
        [CacheData removeCacheDataWithType:0 andID:0];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清除缓存成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        
    } else if ((indexPath.section == 1)&&(indexPath.row == 1)) {
        
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
