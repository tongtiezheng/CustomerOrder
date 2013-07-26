//
//  CommentViewController.m
//  CustomerOrder
//
//  Created by ios on 13-7-26.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "CommentList.h"
#import "PersonCommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize tableView = _tableView;
@synthesize mArray = _mArray;
@synthesize storeInfo = _storeInfo;

@synthesize refreshing = _refreshing;
@synthesize curpage = _curpage;

- (void)dealloc
{
    [_tableView release];
    [_mArray release];
    
    [super dealloc];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//自定义导航按钮
- (void)customNavigationBarButton
{
    
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //自定义导航栏右边的按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"MyComments_X.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(startComment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customNavigationBarButton];
    
    _mArray = [[NSMutableArray alloc]init];
    
    //创建刷新表格
    _tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 44 - 20 - 50) pullingDelegate:self];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    //每次进入刷新数据
    if (self.curpage == 0) {
        
        [self.tableView launchRefreshing];
        
    }
}


//自定义返回按钮
- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}


//JSON 解析
- (void)startJSONParserWithCurpage:(int)cPage shop_id:(int)shop_id
{
    HD = [[[HTTPDownload alloc]init]autorelease];
    HD.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:GET_COMMENT_LIST_API];
    NSString *argument = [NSString stringWithFormat:GET_COMMENT_LIST_ARGUMENT,cPage,shop_id];
    
    [HD downloadFromURL:urlStr withArgument:argument];
    
}

#pragma mark
#pragma mark -- HTTPDownload delegate
- (void)downloadDidFinishLoading:(HTTPDownload *)hd
{
    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:HD.mData options:nil error:nil];
    NSLog(@"--评论内容--%@",dic);
    
    if (dic != nil && [dic allKeys].count > 1) {
        
        NSString *curpageStr = [dic objectForKey:@"curpage"];
        self.curpage = [curpageStr integerValue];
        NSLog(@"下载完成 curpage ---- >> %d",self.curpage);
        NSLog(@"下载完成 [dic allKeys].count ---- >> %d",[dic allKeys].count);
        
        for (int i = 0; i <= [dic allKeys].count - 2; i++) {
            
            CommentList *cList = [[[CommentList alloc]init]autorelease];
            NSDictionary *subDic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            
            cList.avmoney = [subDic objectForKey:@"avmoney"];
            cList.c_id = [subDic objectForKey:@"c_id"];
            cList.content = [subDic objectForKey:@"content"];
            cList.grade = [subDic objectForKey:@"grade"];
            cList.publish = [subDic objectForKey:@"publish"];
            
            
            [self.mArray addObject:cList];
        }
        
         [self.tableView reloadData];
    }
    
   
    
}


- (void)downloadDidFail:(HTTPDownload *)hd
{
    NSLog(@"下载失败！");
}



//进入评论页面
- (void)startComment
{
    PersonCommentViewController *pComment = [[PersonCommentViewController alloc]init];
    pComment.storeInfo = self.storeInfo;
    [self.navigationController pushViewController:pComment animated:YES];
    [pComment release];
    
}


#pragma mark - Table view data source
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
    static NSString *CellIdentifier = @"Cell";
    CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    CommentList *cListInfo = [self.mArray objectAtIndex:indexPath.row];
    
    //    cell.title.text = @"沙漠的鱼骨头";
    //    cell.pGrade.image = [UIImage imageNamed:@"UserLevel30@2x.png"];
    //    cell.sGrade.image = [UIImage imageNamed:@"ShopStar50.png"];
    
    cell.average.text = cListInfo.avmoney;
    cell.content.text = cListInfo.content;
    cell.date.text = cListInfo.publish;
    
    
    float selectGrade = [cListInfo.grade floatValue];
    
    if (selectGrade == 0) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar0.png"];
        
    }else if (selectGrade == 1) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar10.png"];
        
    } else if (selectGrade == 2) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar20.png"];
        
    }else if (selectGrade == 2.5) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar25.png"];
        
    }else if (selectGrade == 3) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar30.png"];
        
    }else if (selectGrade == 3.5) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar35.png"];
        
    }else if (selectGrade == 4) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar40.png"];
        
    }else if (selectGrade == 4.5) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar45.png"];
        
    }else if (selectGrade == 5) {
        cell.sGrade.image = [UIImage imageNamed:@"ShopStar50.png"];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell不被选择
    
    
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}



#pragma mark - load data 

- (void)loadData {
    
       if (self.refreshing) {
        
        self.curpage = 0;
        self.refreshing = NO;
        [self.mArray removeAllObjects];
    }
    
    
    if (self.curpage != -1) {
        
        [self startJSONParserWithCurpage:self.curpage shop_id:[self.storeInfo.storeid intValue]];
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


#pragma mark - PullingRefreshTableViewDelegate

- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"YYYY-MM-dd HH:mm";
    NSString *strDate = [df stringFromDate:[NSDate date]];//获取当前时间
    NSDate *date = [df dateFromString:strDate];
    [df release];
    
    return date;
}


- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0f];
}

#pragma mark - ScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
