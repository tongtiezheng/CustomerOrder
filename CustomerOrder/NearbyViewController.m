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

@interface NearbyViewController ()

@end

@implementation NearbyViewController
@synthesize tableView = _tableView;
@synthesize searchDidplay = _searchDidplay;

@synthesize mArray = _mArray;
@synthesize mapView = _mapView;


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
    [_mArray release];
    [_mapView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"附近商户";
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_mapView];
    
    
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
    
    _mArray = [[NSMutableArray alloc]init];
    
    [self startJSONParserWithCurpage:0 pro_id:0];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    _mapView.showsUserLocation = YES;
    NSLog(@"%f ---- %f",_mapView.userLocation.coordinate.latitude,_mapView.userLocation.coordinate.longitude);
}

- (void)viewWillDisappear:(BOOL)animated
{
    _mapView.showsUserLocation = NO;
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
//        NSString *curpageStr = [dic objectForKey:@"curpage"];
//        curpage = [curpageStr integerValue];
//        NSLog(@"下载完成 curpage ---- >> %d",curpage);
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
        
        [self.tableView reloadData];
    }
}


- (void)downloadDidFail:(HTTPDownload *)hd
{
    NSLog(@"下载失败！");
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
    return [self.mArray count];
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
    
    StoreList *nStoreInfo = [self.mArray objectAtIndex:indexPath.row];
    
    [cell.leftImgView setImageWithURL:[NSURL URLWithString:nStoreInfo.pic] placeholderImage:[UIImage imageNamed:@"cellBg.png"]];
    cell.title.text = nStoreInfo.name;
    cell.address.text = nStoreInfo.address;
    cell.average.text = nStoreInfo.avmoney;
    
    
    float selectGrade = [nStoreInfo.grade floatValue];
    
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

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.bounds.size.width - 44, 30, 40, 20)];
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
