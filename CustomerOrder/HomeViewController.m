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

#import "CacheData.h"
#import "CheckNetwork.h"

#import "UserInfo.h"

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
    [cityBtn setShowsTouchWhenHighlighted:YES];
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
    
    NSLog(@"%@",NSHomeDirectory());
    
    [self customNavigationBtn];
    [self scrollViewMethod];
    [self customTableViewAndRefreshView];
    
    //载入等待指示页面
    waitView = [[WaitingView alloc]initWithFrame:CGRectMake(0, 120, 320, HEIGHT- 44 - 49 - 20 - 120)];
    [self.view addSubview:waitView];
    [waitView release];
    NSLog(@"sizeof(waitView) %li",sizeof(waitView));
    _mArray = [[NSMutableArray alloc]init];
    
    //开始解析，默认全部数据
    if ([CheckNetwork isNetworkRunning]) {
        
        curpage = 0;
        [self startJSONParserWithCurpage:curpage pro_id:0];
        //启动等待指示页面
        [waitView startWaiting];

    }else {
        
        [waitView removeFromSuperview];
        [self readUserDefaultsCacheData];
    }
    
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
        self.refreshTableView = refreshView;
        [refreshView release];
    }
    
    //  update the last update date
    [self.refreshTableView refreshLastUpdatedDate];
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
    
    [cityBtn setTitle:cityName forState:UIControlStateNormal];
    
    //选择城市，重新载入对应数据
    [self egoRefreshTableHeaderDidTriggerRefresh:_refreshTableView];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

-(void)reloadTableViewDataSource {
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    
    if (![CheckNetwork isNetworkRunning]) {
        
        [_mArray removeAllObjects];
        [self.customTV reloadData];
        
    } else {
        
        [_mArray removeAllObjects];
    
        curpage = 0;
    
        [self startJSONParserWithCurpage:curpage pro_id:pro_ID];
    
    
        _reloading = YES;
   
    
        [self.customTV.tableFooterView removeAllSubviews];
    
        [self createTableFooterWithTitle:@"上拉加载更多"];
        
    }
}

-(void)doneLoadingTableViewData {
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:self.customTV];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_search resignFirstResponder];
    [_refreshTableView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_refreshTableView)
    {
        [_refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];

    }
    
    //上拉到最底部时显示更多数据
    if(!_loadingMore && (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        [self loadDataBegin];
        
    }
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
    
    return _reloading; // should return if data source model is reloading
}

-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
    
    return[NSDate date]; // should return date data source was last changed
}


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
    if (![CheckNetwork isNetworkRunning]) {
        
        [_mArray removeAllObjects];
        [self.customTV reloadData];
        
    }else if (curpage != -1) {
        
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
        [self createTableFooterWithTitle:@"加载完毕"];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据已全部加载完毕！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
       
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
    SelectCityViewController *selectCity = [[SelectCityViewController alloc]init];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:selectCity];
    [self presentViewController:na animated:YES completion:nil];
    [selectCity release];
    [na release];
}


//地图定位
- (void)searchSelfLocation:(id)sender
{
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

#pragma mark
#pragma mark -- handle cache method 
//读取缓存
- (void)readUserDefaultsCacheData
{
    NSData *data = [CacheData getCache:0 andID:0];
    NSLog(@">>>>>>沙盒数据>>>>>>%@",data);
     NSLog(@"读取缓存 判断缓存类型%d",cacheID);
    if (data != nil) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dic != nil&&[dic allKeys].count > 1) {
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
            NSLog(@"----[_mArray count]----%d",[_mArray count]);
            [self.customTV reloadData];
        }
    }
}


#pragma mark
#pragma mark -- HTTPDownloadDelegate Method
//下载完成
- (void)downloadDidFinishLoading:(HTTPDownload *)hd
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:HD.mData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"下载完成 dic **** >>%@",dic);
    if (dic != nil&&[dic allKeys].count > 1) {
        NSString *curpageStr = [dic objectForKey:@"curpage"];
        curpage = [curpageStr integerValue];
        NSLog(@"下载完成 curpage ---- >> %d",curpage);
        NSLog(@"下载完成 [dic allKeys].count ---- >> %d",[dic allKeys].count);

        for (int i = 0; i <= [dic allKeys].count - 2; i++) {
            
            StoreList *storeList = [[[StoreList alloc]init]autorelease];
            NSDictionary *subDic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            storeList.pic = [subDic objectForKey:@"pic"];
            storeList.name = [subDic objectForKey:@"name"];
            storeList.grade = [subDic objectForKey:@"grade"];
            storeList.avmoney = [subDic objectForKey:@"avmoney"];
            storeList.address = [subDic objectForKey:@"address"];
            storeList.tel = [subDic objectForKey:@"tel"];
            storeList.lat = [subDic objectForKey:@"lat"];//纬度g_lat
            storeList.lng = [subDic objectForKey:@"lng"];//经度g_lng
            storeList.g_lat = [subDic objectForKey:@"g_lat"];
            storeList.g_lng = [subDic objectForKey:@"g_lng"];
            storeList.description = [subDic objectForKey:@"description"];
            storeList.storeid = [subDic objectForKey:@"id"];
            
            [self.mArray addObject:storeList];
        }
        
        [self.customTV reloadData];
        NSLog(@"下载完成 数组个数---- >>%d",self.mArray.count);
        [waitView stopWaiting];
        [self hudWasHidden:HUD];
        
    } else if ([dic allKeys].count == 1){
        
        [self.mArray removeAllObjects];
        [self.customTV reloadData];
        [self createTableFooterWithTitle:nil];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有数据可供加载" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    
    /*****************************/

    //缓存数据

    [CacheData saveCache:0 andID:0 andData:HD.mData];
    NSLog(@"判断缓存类型%d",pro_ID);
    /*****************************/
}

//下载失败
- (void)downloadDidFail:(HTTPDownload *)hd
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"下载失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
    
    NSLog(@"下载失败");
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
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
        [cell.leftImgView setImageWithURL:[NSURL URLWithString:info.pic] placeholderImage:[UIImage imageNamed:@"cellBg.png"]];
        cell.title.text = info.name;
        cell.address.text = info.address;
        cell.average.text = info.avmoney;
    
        float selectGrade = [info.grade floatValue];
        
//        NSLog(@"----selectGrade----%f",selectGrade);
        
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
            
        } else {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar0.png"];
        
        }
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = indexPath.row;
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
    
    NSString *online_key = [UserInfo getOnline_keyValueWithKey:@"online_key"];
    
    if (online_key) {
        
        OrderViewController *order = [[OrderViewController alloc]init];
        StoreList *listInfo = [self.mArray objectAtIndex:sender.tag];
        order.oStoreInfo = listInfo;
        [self.navigationController pushViewController:order animated:YES];
        [order release];
        
    } else {
    
        UIAlertView *aleart = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登录，请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aleart show];
        [aleart release];

    }
      
    
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
