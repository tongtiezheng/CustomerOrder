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
#import "StoreList.h"
#import "UIImageView+WebCache.h"
#import "PersonLocationViewController.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController
@synthesize tableView = _tableView;
@synthesize refreshing = _refreshing;
@synthesize curpage = _curpage;

@synthesize searchDidplay = _searchDidplay;
@synthesize searchBar = _searchBar;

@synthesize mArray = _mArray;
@synthesize resultArray = _resultArray;
@synthesize testArray = _testArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)dealloc
{
    [_tableView release];
    [_searchDidplay release];
    [_searchBar release];
    
    [_mArray release];
    [_resultArray release];
    [_testArray release];
    
    [super dealloc];
}

//自定义NavigatinBar 
- (void)customNavigationBtn
{
    //导航栏右边 地图确认当前位置
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"定位.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(searchSelfLocation:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    //添加搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    [searchBar setFrame:CGRectMake(0, 0, 320, 44)];
    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar = searchBar;
    [self.view addSubview:searchBar];
    
    UISearchDisplayController *searchCon = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchCon.delegate = self;
    searchCon.searchResultsDelegate = self; //设置代理
    searchCon.searchResultsDataSource = self;//设置搜索结果数据源
    self.searchDidplay = searchCon;//UISearchDisplayController 必须定义成属性
    
    [searchCon release];
    [searchBar release];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"附近商户";
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self customNavigationBtn];

    
    //自定义tableView
    _tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 49 - 44 - 20 -44) pullingDelegate:self];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    _mArray = [[NSMutableArray alloc]init];
    _resultArray = [[NSMutableArray alloc]init];
    _testArray = [[NSArray alloc]init];
    
    //每次进入刷新数据
    if (self.curpage == 0) {
        
        [self.tableView launchRefreshing];
        
    }
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
#pragma mark -- HTTPDownload delegate
- (void)downloadDidFinishLoading:(HTTPDownload *)hd
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:HD.mData options:NSJSONReadingMutableContainers error:nil];
    
    if (dic != nil&&[dic allKeys].count > 1) {
        
        for (int i = 0; i <= [dic allKeys].count - 2; i++) {
            
            NSString *curpageStr = [dic objectForKey:@"curpage"];
            self.curpage = [curpageStr integerValue];
    
            StoreList *storeList = [[[StoreList alloc]init]autorelease];
            NSDictionary *subDic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            storeList.pic = [subDic objectForKey:@"pic"];
            storeList.name = [subDic objectForKey:@"name"];
            storeList.grade = [subDic objectForKey:@"grade"];
            storeList.avmoney = [subDic objectForKey:@"avmoney"];
            storeList.address = [subDic objectForKey:@"address"];
            storeList.tel = [subDic objectForKey:@"tel"];
            storeList.lat = [subDic objectForKey:@"lat"];//百度纬度
            storeList.lng = [subDic objectForKey:@"lng"];//百度经度
            storeList.g_lat = [subDic objectForKey:@"g_lat"];//谷歌纬度
            storeList.g_lng = [subDic objectForKey:@"g_lng"];//谷歌经度
            storeList.description = [subDic objectForKey:@"description"];
            storeList.storeid = [subDic objectForKey:@"id"];
            
            [self.mArray addObject:storeList];
            
            [self.resultArray addObject:storeList.name];
        }
        
        [self.tableView reloadData];
    }
}

- (void)downloadDidFail:(HTTPDownload *)hd
{
    NSLog(@"下载失败！");
}

#pragma mark -- tableView dataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger *rows;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        rows = [self.testArray count];
        
    } else {
    
        rows = [self.mArray count];
    }
    
    return rows;
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
    
    int index = indexPath.row;//取出行标记
        
    if (tableView == self.searchDidplay.searchResultsTableView) {
    
        StoreList *nStoreInfo = [self.mArray objectAtIndex:index];
        [cell.leftImgView setImageWithURL:[NSURL URLWithString:nStoreInfo.pic] placeholderImage:[UIImage imageNamed:@"cellBg.png"]];
        cell.title.text = nStoreInfo.name;
        cell.address.text = nStoreInfo.address;
        cell.average.text = nStoreInfo.avmoney;
        
        float selectGrade = [nStoreInfo.grade floatValue];
        if (selectGrade == 0) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar0.png"];
            
        } else if (selectGrade == 1) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar10.png"];
            
        } else if (selectGrade == 2) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20.png"];
            
        } else if (selectGrade == 2.5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar25.png"];
            
        } else if (selectGrade == 3) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar30.png"];
            
        } else if (selectGrade == 3.5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar35.png"];
            
        } else if (selectGrade == 4) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar40.png"];
            
        } else if (selectGrade == 4.5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar45.png"];
            
        } else if (selectGrade == 5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar50.png"];
            
        } else {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar0.png"];
        }
        
    } else {
        
        StoreList *nStoreInfo = [self.mArray objectAtIndex:index];
        [cell.leftImgView setImageWithURL:[NSURL URLWithString:nStoreInfo.pic] placeholderImage:[UIImage imageNamed:@"cellBg.png"]];
        cell.title.text = nStoreInfo.name;
        cell.address.text = nStoreInfo.address;
        cell.average.text = nStoreInfo.avmoney;

        float selectGrade = [nStoreInfo.grade floatValue];
        if (selectGrade == 0) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar0.png"];
            
        } else if (selectGrade == 1) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar10.png"];
            
        } else if (selectGrade == 2) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20.png"];
            
        } else if (selectGrade == 2.5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar25.png"];
            
        } else if (selectGrade == 3) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar30.png"];
            
        } else if (selectGrade == 3.5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar35.png"];
            
        } else if (selectGrade == 4) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar40.png"];
            
        } else if (selectGrade == 4.5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar45.png"];
            
        } else if (selectGrade == 5) {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar50.png"];
            
        } else {
            cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar0.png"];
        }

    }
        
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.bounds.size.width - 44, 30, 40, 20)];
    [btn setImage:[UIImage imageNamed:@"order.png"] forState:UIControlStateNormal];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(orderStore:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    
    return cell;
}


//进入预订页面
- (void)orderStore:(UIButton *)sender
{
    OrderViewController *order = [[OrderViewController alloc]init];
    StoreList *tempInfo = [self.mArray objectAtIndex:sender.tag];
    order.oStoreInfo = tempInfo;
    [self.navigationController pushViewController:order animated:YES];
    [order release];
}

#pragma mark
#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    StoreList *nStoreInfo = [self.mArray objectAtIndex:indexPath.row];
    detail.storeInfo = nStoreInfo;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

//表格数据加载
- (void)loadData
{
    if (self.refreshing) {
        
        self.curpage = 0;
        self.refreshing = NO;
        [self.mArray removeAllObjects];
    }
    
    
    if (self.curpage != -1) {
        
        [self startJSONParserWithCurpage:self.curpage pro_id:0];
        [self.tableView reloadData];
        
    }
    
    
    if (self.curpage == -1) {
        
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"All Loaded!"];
        self.tableView.reachedTheEnd  = YES;
        
    } else {
        
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd  = NO;
        [self.tableView reloadData];
    }
}

#pragma mark
#pragma mark -- PullingRefreshTableViewDelegate 
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    self.refreshing = YES;
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0f];
}


- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0f];

}

#pragma mark
#pragma mark -- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}


//搜索过滤方法
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString *)scope
{
    if (searchText) {
        
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd]%@",searchText];
        
        self.testArray = [self.resultArray filteredArrayUsingPredicate:resultPredicate];
    }
}

#pragma mark 
#pragma mark -- UISearchDisplayDelegate  实现收索功能 

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
//    
//    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:searchOption]];
//    
//    return YES;
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
