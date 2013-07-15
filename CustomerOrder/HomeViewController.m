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

#import "HTTPDownload.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize customTV = _customTV;
@synthesize search = _search;
@synthesize currentCity = _currentCity;
@synthesize mArray = _mArray;
@synthesize refreshTableView = _refreshTableView;

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
    [cityBtn setTitle:@"默认" forState:UIControlStateNormal];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"%@",NSHomeDirectory());
    
    [self customNavigationBtn];
    [self scrollViewMethod];
    [self customTableViewAndRefreshView];
    
    //开始解析，默认全部数据
    curpage = 0;
    [self startJSONParserWithCurpage:curpage pro_id:0];
    _mArray = [[NSMutableArray alloc]init];
    
    //载入等待指示页面
    waitView = [[WaitingView alloc]initWithFrame:CGRectMake(0, 120, 320, HEIGHT- 44 - 49 - 20 - 120)];
    [self.view addSubview:waitView];
    [waitView release];
    [waitView startWaiting];
    
    //注册通知,接收城市信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackCity:) name:@"SelectCityNotification" object:nil];

}


//自定义表格及刷新按钮
- (void)customTableViewAndRefreshView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, 320,HEIGHT - 49 - 20 - 120 - 44) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.customTV = tableView;
    [self.view addSubview:tableView];
    [tableView release];
    
    if (_refreshTableView == nil) {
        //初始化下拉刷新控件
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.customTV.bounds.size.height, self.view.frame.size.width, self.customTV.bounds.size.height)];
        refreshView.delegate = self;
        //将下拉刷新控件作为子控件添加到UITableView中
        [self.customTV addSubview:refreshView];
        _refreshTableView = refreshView;
        [refreshView release];
    }
    
    //  update the last update date
    [_refreshTableView refreshLastUpdatedDate];
}

//接受到通知的相应方法
- (void)callBackCity:(id)sender
{
    NSNotification *notification = (NSNotification *) sender;
    self.currentCity = [notification.userInfo objectForKey:@"city"];
    
    //截取城市名字
    NSString *str_intercepted = [self.currentCity substringFromIndex:0];
    NSString *str_character = @"/";
    NSRange range = [str_intercepted rangeOfString:str_character];
    NSString *cityName = [str_intercepted substringToIndex:range.location];
    
    //截取城市id
    NSRange idRange = NSMakeRange(cityName.length, self.currentCity.length - cityName.length);
    NSString *cityidStr = [self.currentCity substringWithRange:idRange];
    pro_ID = [[cityidStr substringFromIndex:1] integerValue];
    NSLog(@"--pro_ID--%d",pro_ID);
    
    [cityBtn setTitle:cityName forState:UIControlStateNormal];
    
    //选择城市，重新载入对应数据
    [self egoRefreshTableHeaderDidTriggerRefresh:_refreshTableView];
    
    return;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

-(void)reloadTableViewDataSource {
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    [_mArray removeAllObjects];
    curpage = 0;
    if (pro_ID != 0)
    {
        [self startJSONParserWithCurpage:curpage pro_id:pro_ID];
    } else if (curpage != 1) {
    
        [self startJSONParserWithCurpage:curpage pro_id:0];
    }
    
    _reloading = YES;
    
    [self.customTV.tableFooterView removeAllSubviews];
    [self createTableFooterWithTitle:@"上拉加载更多"];
}

-(void)doneLoadingTableViewData {
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:self.customTV];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshTableView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];
    
    //上拉到最底部时显示更多数据
    if(!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        [self loadDataBegin];
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
}

-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return[NSDate date]; // should return date data source was last changed
}


/* ***

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
//开始重新加载时调用的方法
- (void)reloadTableViewDataSource{
    _reloading = YES;
    //开始刷新后执行后台线程，在此之前可以开启HUD或其他对UI进行阻塞
    [NSThread detachNewThreadSelector:@selector(doInBackground) toTarget:self withObject:nil];
}

//完成加载时调用的方法
- (void)doneLoadingTableViewData{
    NSLog(@"doneLoadingTableViewData");
    
    _reloading = NO;
    [_refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:self.customTV];
    //刷新表格内容
    [self.customTV reloadData];
}

#pragma mark -
#pragma mark Background operation
//这个方法运行于子线程中，完成获取刷新数据的操作
-(void)doInBackground
{
    NSLog(@"doInBackground");
    
    curpage = 0;
    [self.mArray removeAllObjects];
    [self startJSONParserWithCurpage:curpage];
    
    
    [NSThread sleepForTimeInterval:3];
    
    //后台操作线程执行完后，到主线程更新UI
    [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉被触发调用的委托方法
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
}

//返回当前是刷新还是无刷新状态
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

//返回刷新时间的回调方法
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//滚动控件的委托方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshTableView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark - Refresh table view

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_refreshTableView)
    {
        [_refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];
    }
   
    // 下拉到最底部时显示更多数据
	if(!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        [self loadDataBegin];
	}
}

******* */


// 开始加载数据
- (void) loadDataBegin
{
    if (_loadingMore == NO)
    {
        _loadingMore = YES;
        
        [self loadDataing];
    }
}


// 加载数据中
- (void) loadDataing
{
    if (curpage != -1) {
        
        [self startJSONParserWithCurpage:curpage pro_id:pro_ID];
    }
    
    [self indicatorView];
    
	[self loadDataEnd];
}

// 加载数据完毕
- (void) loadDataEnd
{
    _loadingMore = NO;
    if (curpage == -1) {
        [self hudWasHidden:HUD];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据已全部加载完毕！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        [self createTableFooterWithTitle:@"加载完毕"];
    } else {
        
        [self createTableFooterWithTitle:@"上拉加载更多"];
    }
}

// 创建表格底部
- (void) createTableFooterWithTitle:(NSString *)text
{
    self.customTV.tableFooterView = nil;
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.customTV.bounds.size.width, 40.0f)];
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40.0f)];
    [loadMoreText setTextAlignment:NSTextAlignmentCenter];
    [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    [loadMoreText setText:text];
    [tableFooterView addSubview:loadMoreText];
    self.customTV.tableFooterView = tableFooterView;
    [loadMoreText release];
    [tableFooterView release];
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
- (void)startJSONParserWithCurpage:(int)cPage pro_id:(int)pro_id
{
    HD = [[[HTTPDownload alloc]init]autorelease];
    HD.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:STORE_LIST_API];
    NSString *argument = [NSString stringWithFormat:STORE_LIST_ARGUMENT,cPage,pro_id];
    NSLog(@"JSON解析 argument ---- >%@",argument);
    [HD downloadFromURL:urlStr withArgument:argument];
    
}

#pragma mark -- HTTPDownloadDelegate Method
//下载完成
- (void)downloadDidFinishLoading:(HTTPDownload *)hd
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:HD.mData options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"++++>>%@",[dic objectForKey:@"1"]);
    NSLog(@"下载完成 dic **** >>%@",dic);
    if (dic != nil) {
        
        NSString *curpageStr = [dic objectForKey:@"curpage"];
        curpage = [curpageStr integerValue];
        NSLog(@"下载完成 curpage ---- >> %d",curpage);
        for (int i = 0; i <= [dic allKeys].count - 2; i++) {
            
            StoreList *storeList = [[[StoreList alloc]init]autorelease];
            NSDictionary *subDic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            storeList.pic = [subDic objectForKey:@"pic"];
            storeList.name = [subDic objectForKey:@"name"];
            storeList.grade = [subDic objectForKey:@"grade"];
            storeList.avmoney = [subDic objectForKey:@"avmoney"];
            storeList.address = [subDic objectForKey:@"address"];
            storeList.tel = [subDic objectForKey:@"tel"];
            storeList.lat = [subDic objectForKey:@"lat"];//纬度
            storeList.lng = [subDic objectForKey:@"lng"];//经度
            storeList.description = [subDic objectForKey:@"description"];
            storeList.storeid = [subDic objectForKey:@"id"];
            
            [self.mArray addObject:storeList];
        }
        
        [self.customTV reloadData];
        NSLog(@"下载完成 数组个数---->>%d",self.mArray.count);
        [waitView stopWaiting];
        [self hudWasHidden:HUD];
    }
}
//下载失败
- (void)downloadDidFail:(HTTPDownload *)hd
{
    NSLog(@"下载失败");
}

#pragma mark -

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    NSLog(@"Hud: %@", hud);
    
    // Remove HUD from screen when the HUD was hidded
    
    [HUD removeFromSuperview];
    [HUD release];
     HUD = nil;
    
}
//指示视图方法
- (void)indicatorView
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            HUD.progress = progress;
            usleep(10000);
        }
    } completionBlock:^{
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }];
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

#pragma mark -- tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_mArray count] == 0) {
        return nil;
    }
    
    return [_mArray count];
    
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
    
    if (_mArray.count != 0) {
        
        StoreList *info = [_mArray objectAtIndex:indexPath.row];
        
        [cell.leftImgView setImageWithURL:[NSURL URLWithString:info.pic] placeholderImage:[UIImage imageNamed:nil]];
        cell.title.text = info.name;
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20@2x.png"];
        cell.address.text = info.address;
        cell.average.text = info.avmoney;

    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.bounds.size.width - 50, 30, 40, 20)];
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

//搜索栏的隐藏与显示
- (void)viewWillDisappear:(BOOL)animated
{
    [self.search setHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.search setHidden:NO];
}


#pragma mark -- tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//cell返回时取消选中状态
    StoreList *storeListInfo = [self.mArray objectAtIndex:indexPath.row];
    detail.storeInfo = storeListInfo;
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
    [_refreshTableView release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SelectCityNotification" object:nil];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
