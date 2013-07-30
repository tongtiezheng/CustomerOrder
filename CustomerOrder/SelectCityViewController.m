//
//  SelectCityViewController.m
//  CustomerOrder
//
//  Created by ios on 13-7-9.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "SelectCityViewController.h"
#import "CityName.h"
#import "SetColor.h"
#import "ChineseToPinyin.h"
#import "WaitingView.h"

@interface SelectCityViewController ()

@end

@implementation SelectCityViewController
@synthesize cityTableView = _cityTableView;
@synthesize searchBar = _searchBar;
@synthesize mArray = _mArray;
@synthesize kArray = _kArray;
@synthesize mData = _mData;
@synthesize selectCity = _selectCity;
@synthesize cityKeys = _cityKeys;
@synthesize cityList = _cityList;

-(void)dealloc
{
    [_cityTableView release];
    [_searchBar release];
    [_mArray release];
    [_mData release];
    [_selectCity release];
    [_cityKeys release];
    [_cityList release];
    [_kArray release];
    
    [super dealloc];
}

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
    
    self.title = @"城市列表";
    
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //重写右边返回按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"返回" forState:UIControlStateNormal];
    [rightBtn setShowsTouchWhenHighlighted:YES];
    [rightBtn addTarget:self action:@selector(backRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];

    
    //添加搜索栏
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];

    //创建表格
    _cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 20 - 44 - 49) style:UITableViewStylePlain];
    _cityTableView.dataSource = self;
    _cityTableView.delegate = self;
    [self.view addSubview:_cityTableView];
    
    //开始解析
    [self JSONParser];

    //等待指示页面
    waitingView = [[WaitingView alloc]initWithFrame:CGRectMake(0, 44, 320, HEIGHT-44-44-20)];
    [self.view addSubview:waitingView];
    [waitingView release];
    [waitingView startWaiting];
}

//返回按钮
- (void)backRight
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//JSON 解析
- (void)JSONParser
{
    NSString *urlStr = [NSString stringWithFormat:CITY_LIST_API];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
//    NSString *str = @"op=getProvince";
    NSData *data = [CITY_LIST_ARGUMENT dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -- NSURLConnectionDataDelegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.mArray = [[NSMutableArray alloc]init];
    self.kArray = [[NSMutableArray alloc]init];
    self.mData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSArray *array = [NSJSONSerialization JSONObjectWithData:self.mData options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in array) {
        CityName *cityName = [[[CityName alloc]init]autorelease];
        NSMutableString *cityInfo = [NSMutableString string];
        
        cityName.name = [dic objectForKey:@"name"];
        cityName.cityid = [dic objectForKey:@"id"];
        
        [cityInfo appendString:cityName.name];
        [cityInfo appendString:@"/"];
        [cityInfo appendString:cityName.cityid];
       
        [self.mArray addObject:cityInfo];
    }
    
    //
    for (int i = 0; i < self.mArray.count; i++) {
        int min = i;
        for (int j = i+1; j<self.mArray.count; j++) {
            NSString *minCityName = [self.mArray objectAtIndex:min];
            NSString *minCityPinYin = [ChineseToPinyin pinyinFromChiniseString:minCityName];
            NSString *minFirstWord = [minCityPinYin substringToIndex:1];
            
            NSString *cityName = [self.mArray objectAtIndex:j];
            NSString *cityPinYin = [ChineseToPinyin pinyinFromChiniseString:cityName];
            NSString *firstWord = [cityPinYin substringToIndex:1];
            
            NSComparisonResult result = [minFirstWord compare:firstWord];
            if (result == NSOrderedDescending){
                min = j;
            }
        }
        if (min != i) {
            NSString *minCity = [self.mArray objectAtIndex:min];
            [self.mArray replaceObjectAtIndex:min withObject:[self.mArray objectAtIndex:i]];
            [self.mArray replaceObjectAtIndex:i withObject:minCity];
        }
    }

    
    //初始化索引集合和cityList字典
    self.cityKeys = [NSMutableOrderedSet orderedSet];
    self.cityList = [NSMutableDictionary dictionary];
    
    //
    for (int i = 0; i < self.mArray.count; i++) {
        NSString *cityName = [self.mArray objectAtIndex:i];
        NSString *cityPinYin = [ChineseToPinyin pinyinFromChiniseString:cityName];
        NSString *firstWord = [cityPinYin substringToIndex:1];
        [self.cityKeys addObject:firstWord];
        NSMutableArray *cityNames = [self.cityList objectForKey:firstWord];
        if (!cityNames) {
            cityNames = [NSMutableArray array];
            [self.cityList setObject:cityNames forKey:firstWord];
        }
        [cityNames addObject:cityName];
    }

    [_cityTableView reloadData];
    
    
    //移除等待页面
    [waitingView stopWaiting];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}


#pragma mark -- tableView data source 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.cityKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [[self.cityList objectForKey:[self.cityKeys objectAtIndex:section]] count];
}

#pragma mark -- tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    NSString  *cityName = [[self.cityList objectForKey:[self.cityKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    //截取城市名字
    NSString *str_intercepted = [cityName substringFromIndex:0];
    NSString *str_character = @"/";
    NSRange range = [str_intercepted rangeOfString:str_character];
    NSString *subCityName = [str_intercepted substringToIndex:range.location];
    cell.textLabel.text = subCityName;

    //设置cell被点击之后的背景颜色
    SetColor *cellBG = [SetColor shareInstance];
    [cellBG setCellBackgroundColor:cell];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectCity = [[self.cityList objectForKey:[self.cityKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    if (self.selectCity)
    {
        NSDictionary *city = [NSDictionary dictionaryWithObject:self.selectCity forKey:@"city"];
        NSNotification *notification = [NSNotification notificationWithName:@"SelectCityNotification" object:self userInfo:city];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//设置每部分标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.cityKeys objectAtIndex:section];
}
//添加右侧索引
-  (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.cityKeys array];
}


#pragma mark -- searchBar delegate  
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}


#pragma mark -- scrollView delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
