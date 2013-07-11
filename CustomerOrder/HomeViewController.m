//
//  HomeViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "HomeViewController.h"

#import "CycleScrollView.h"
#import "CustomHomeCell.h"

#import "SelectCityViewController.h"
#import "PersonLocationViewController.h"
#import "OrderViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"

#import "SetColor.h"
#import "StoreList.h"
#import "WaitingView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize customTV = _customTV;
@synthesize search = _search;


@synthesize currentCity = _currentCity;


@synthesize mArray = _mArray;
@synthesize mData = _mData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//自定义导航栏上的按钮及背景颜色
- (void)customNavigationBtn
{
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    //导航栏左边按钮
    cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cityBtn setFrame:CGRectMake(0, 0, 60, 44)];
    [cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    [cityBtn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:cityBtn];
    self.navigationItem.leftBarButtonItem = leftBtn;
    [leftBtn release];
    
    //导航栏中间 搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 0, 220, 40)];
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];//去掉搜索栏背景颜色
    [searchBar setPlaceholder:@"输入商铺名称搜索"];
    searchBar.delegate = self;
    self.search = searchBar;
    [self.navigationController.view addSubview:searchBar];
    [searchBar release];
    
    //导航栏右边 地图确认当前位置
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"定位.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchSelfLocation:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

//滚动视图
- (void)scrollViewMethod
{
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    
    [picArray addObject:[UIImage imageNamed:@"1.jpg"]];
    [picArray addObject:[UIImage imageNamed:@"2.jpg"]];
    [picArray addObject:[UIImage imageNamed:@"3.jpg"]];
    [picArray addObject:[UIImage imageNamed:@"4.jpg"]];
    
    //    CFShow(picArray); //显示数组对象
    CycleScrollView *cycle = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)
                                                     cycleDirection:CycleDirectionLandscape
                                                           pictures:picArray];
    [self.view addSubview:cycle];
    [cycle release];
    [picArray release];
}

//自定义表格
- (void)customTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, 320,HEIGHT - 49 - 20 - 120 - 44) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.customTV = tableView;
    [self.view addSubview:tableView];
    [tableView release];
    
    //加入指示器视图
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"%@",NSHomeDirectory());
    
    [self customNavigationBtn];
    [self scrollViewMethod];
    [self customTableView];
    
    //注册通知,接收城市信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackCity:) name:@"SelectCityNotification" object:nil];
    
    [self JSONParser];
}

//选择城市
- (void)selectCity:(id)sender
{
    NSLog(@"选择城市");
    SelectCityViewController *selectCity = [[SelectCityViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:selectCity];
//     na.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:na animated:YES completion:nil];
    [selectCity release];
    [na release];
}

//接受到通知相应方法
- (void)callBackCity:(id)sender
{
    NSNotification *notification =  (NSNotification *) sender;
    NSLog(@"%@",notification);
    self.currentCity = [notification.userInfo objectForKey:@"city"];

    [cityBtn setTitle:self.currentCity forState:UIControlStateNormal];
    
}


//地图定位
- (void)searchSelfLocation:(id)sender
{
    NSLog(@"显示当前位置");
    PersonLocationViewController *location = [[PersonLocationViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:location];
    na.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:na animated:YES completion:nil];
    [na release];
    [location release];

}


//JSON 解析
- (void)JSONParser
{
    NSString *urlStr = [NSString stringWithFormat:STORE_LIST_API];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSData *data = [STORE_LIST_ARGUMENT dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -- NSURLConnectionDataDelegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.mArray = [[NSMutableArray alloc]init];
    self.mData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.mData options:NSJSONReadingMutableContainers error:nil];

    NSLog(@"++++>>%@",[dic objectForKey:@"0"]);
    for (int i = 0; i <= [dic allKeys].count; i++) {
        
        StoreList *storeList = [[[StoreList alloc]init]autorelease];
    
        NSDictionary *subDic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
    
        storeList.name = [subDic objectForKey:@"name"];
        
        NSLog(@"---->>%@",storeList.name);
        
    }
    
       
    
}
    
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}



#pragma mark 
#pragma mark -- UISearchBar delegate 
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    switch (searchBar.tag)
    {
        case 0:
            if (![self.search isExclusiveTouch])
            {
                [self.search resignFirstResponder];
            }
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- scrollView delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![self.search isExclusiveTouch])
    {
        [self.search resignFirstResponder];
    }

}

#pragma mark -- tableView data source

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
    
    //设置选中cell时的颜色
    SetColor *instance = [SetColor shareInstance];
    [instance setCellBackgroundColor:cell];
    
    
    cell.leftImgView.image = [UIImage imageNamed:@"4.jpg"];
    cell.title.text = @"店铺名称";
    cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20@2x.png"];
    cell.address.text = @"店铺地址";
    cell.average.text = @"40";
//    cell.distance.text = @"190m";
    
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
    
//    //判断用户是否是会员,如果是，提示先登录；如果不是，提示先注册
//    if () {
//        
//    }else
//    {
//    
//    }
    
    UIAlertView *aleart = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登录，请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aleart show];
    [aleart release];
    
}

#pragma mark -- UIAlertView delegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
        {
            LoginViewController *login = [[LoginViewController alloc]init];
//            [self.navigationController pushViewController:reg animated:YES];
            UINavigationController *loginNa = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:loginNa animated:YES completion:nil];
            
            [login release];
            [loginNa release];
        }
            break;
        default:
            break;
    }
}

//
- (void)viewWillDisappear:(BOOL)animated
{
    [self.search setHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.search setHidden:NO];
}
//

#pragma mark -- tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//cell返回时取消选中状态
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (void)dealloc
{
    [_customTV release];
    [_search release];
    [_currentCity release];
    [_mArray release];
    [_mData release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectCityNotification" object:nil];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
