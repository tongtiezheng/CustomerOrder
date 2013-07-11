//
//  DetailViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailDisplayCell.h"
#import "CommentViewController.h"
#import "StoreLocationViewController.h"
#import "OrderViewController.h"
#import "CONST.h"
#import "NYHAppDelegate.h"

#import "SetColor.h"

#define CONTENT @"咖啡厅座位预订 测试版 http://hxhd.cn"
#define SHARE_URL @"http://www.sharesdk.cn"


@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize imgArray = _imgArray;
@synthesize othersArray = _othersArray;
@synthesize itemForDataBase = _itemForDataBase;

@synthesize appDelegate = _appDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
         _appDelegate = (NYHAppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

//自定义导航栏上的按钮
- (void)customNavigationBtn
{
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //自定义导航栏右边收藏按钮
    
    UIButton *rigntCollectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigntCollectBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [rigntCollectBtn setImage:[UIImage imageNamed:@"common_titlebar_icon_favorite_off_rest@2x.png"] forState:UIControlStateNormal];
    [rigntCollectBtn addTarget:self action:@selector(collectData:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigntCollectBar = [[UIBarButtonItem alloc]initWithCustomView:rigntCollectBtn];
    self.navigationItem.rightBarButtonItem = rigntCollectBar;
    [rigntCollectBar release];
    
    //自定义导航栏右边分享按钮
    
    rigntShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigntShareBtn setFrame:CGRectMake(220, 0, 44, 44)];
    [rigntShareBtn setImage:[UIImage imageNamed:@"icon_Share_D@2x.png"] forState:UIControlStateNormal];
    [rigntShareBtn addTarget:self action:@selector(shareData:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:rigntShareBtn];
    
}

//数据收藏
- (void)collectData:(id)dender
{
    NSLog(@"收藏成功");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功！" delegate:self cancelButtonTitle:@"取消收藏" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

#pragma mark -- UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            NSLog(@"%d",buttonIndex);
            break;
        case 1:
            
            NSLog(@"%d",buttonIndex);
            break;
            
        default:
            break;
    }
}


//分享数据
- (void)shareData:(id)sender
{
    NSLog(@"开始分享");
    //分享的图片
    id<ISSCAttachment> fileName = [ShareSDK pngImageWithImage:[UIImage imageNamed:@"Icon.png"]];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:CONTENT
                                       defaultContent:nil
                                                image:fileName
                                                title:@"CustomerOrder"
                                                  url:SHARE_URL
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeImage];
    
    ///////////////////////    
    //定制信息
    
    //定制QQ分享信息
    [publishContent addQQUnitWithType:INHERIT_VALUE
                              content:INHERIT_VALUE
                                title:@"Hello QQ!"
                                  url:INHERIT_VALUE
                                image:fileName];
    //定制QQ空间分享
    [publishContent addQQSpaceUnitWithTitle:@"Hello QQ空间"
                                        url:INHERIT_VALUE
                                       site:nil
                                    fromUrl:nil
                                    comment:INHERIT_VALUE
                                    summary:INHERIT_VALUE
                                      image:nil
                                       type:INHERIT_VALUE
                                    playUrl:nil
                                       nswb:nil];

    //定制邮件信息
    [publishContent addMailUnitWithSubject:@"Hello Mail"
                                   content:INHERIT_VALUE
                                    isHTML:[NSNumber numberWithBool:YES]
                               attachments:INHERIT_VALUE
                                        to:nil
                                        cc:nil
                                       bcc:nil];
    //结束定制信息
    ///////////////////////
    
        
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];

    //设置iPhone显示容器
    [container setIPhoneContainerWithViewController:self];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:_appDelegate.viewDelegate
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                              oneKeyShareList:nil
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:_appDelegate.viewDelegate
                                                          friendsViewDelegate:_appDelegate.viewDelegate
                                                        picViewerViewDelegate:nil];
    //自定义分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeRenren,ShareTypeWeixiSession,ShareTypeSMS,ShareTypeQQ,ShareTypeQQSpace,ShareTypeMail,ShareTypeTencentWeibo, nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo>
                                     error, BOOL end) {
                                
                                if (ShareTypeMail)
                                {
                                    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
                                }
                                
                                if (ShareTypeSMS) {
                                    
                                    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
                                }
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                            
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"分享成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                    [alert show];
                                    [alert release];
                                }
                                else if (state == SSPublishContentStateFail)
                                {   
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"分享失败\n%@", [error errorDescription]] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                    [alert show];
                                    [alert release];
                                }
                            }];
}


//自定义返回按钮
- (void)backLeft
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [rigntShareBtn setHidden:NO];    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [rigntShareBtn setHidden:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self customNavigationBtn];
    
    UIImage *addressImg = [UIImage imageNamed:@"Detail_AddressIcon.png"];
    UIImage *telImg = [UIImage imageNamed:@"Detail_PhoneIcon.png"];
    _imgArray = [[NSArray alloc]initWithObjects:addressImg,telImg, nil];
    
    _othersArray = [[NSArray alloc]initWithObjects:@"小红门路312号",@"87699988", nil];
    
    //阻止 tableview 滑动
    [self.tableView setBounces:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetColor *instance = [SetColor shareInstance];
    
    if (indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"Cell1";
        DetailDisplayCell *cell = (DetailDisplayCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[DetailDisplayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        }
        
        cell.title.text = @"华信咖啡厅";
        cell.leftImgView.image = [UIImage imageNamed:@"2.jpg"];
        cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20@2x.png"];
        cell.average.text = @"81";
        
        
        UIButton *order = [UIButton buttonWithType:UIButtonTypeCustom];
        [order setFrame:CGRectMake(245, 85, 80, 30)];
        [order setImage:[UIImage imageNamed:@"order.png"] forState:UIControlStateNormal];
        [order addTarget:self action:@selector(orderSeat:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:order];
        

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.row == 1||indexPath.row == 2) {
        
        static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.imageView.image = [_imgArray objectAtIndex:indexPath.row - 1];
            cell.textLabel.text = [_othersArray objectAtIndex:indexPath.row - 1];
        }
            
        //设置选中cell时的背景颜色
        [instance setCellBackgroundColor:cell];
        return cell;
        
    } else if (indexPath.row == 3)
    
    {
        static NSString *CellIdentifier = @"Cell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 290, 20)];
            nameLabel.text = @"网友评论";
            nameLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:nameLabel];
            [nameLabel release];

            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 290, 80)];
            label.text = @"一些网友的评论 赶快发表你的评论 此处要多加一些内容 显示多行 一定要加油呀 哈哈哈哈哈哈";
            label.numberOfLines = 0;
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
            [label release];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
       
        [instance setCellBackgroundColor:cell];
        return cell;
       
    } else
    
    {
        static NSString *CellIdentifier = @"Cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 290, 50)];
            label.text = @"评论（共49条）";
            [cell.contentView addSubview:label];
            [label release];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [instance setCellBackgroundColor:cell];
        return cell;
    }
}


- (void)orderSeat:(UIButton *)sender
{
    NSLog(@"点击预订你的桌位");
    OrderViewController *order = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
    [order release];
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 120.5;
    }
    
    if (indexPath.row == 3)
    {
        return 100;
    }

    return 48.0f;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        StoreLocationViewController *storeLocation = [[StoreLocationViewController alloc]init];
        [self.navigationController pushViewController:storeLocation animated:YES];
        [storeLocation release];
        
    }
    if (indexPath.row == 2) {
        
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[_othersArray objectAtIndex:1], nil];
        [action showFromTabBar:self.tabBarController.tabBar];
        [action release];
    }
    if (indexPath.row == 3) {
        CommentViewController *comment = [[CommentViewController alloc]init];
        [self.navigationController pushViewController:comment animated:YES];
        [comment release];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}
#pragma mark -- UIActionSheet delegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        NSLog(@"开始拨打电话");
        
        NSString *telStr = [NSString stringWithFormat:@"tel://%@",[_othersArray objectAtIndex:1]];
        NSLog(@"%@",telStr);
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];//是用这种方式拨打电话，当用户结束通话后，iphone界面会停留在电话界面，用如下方式，可以使得用户结束通话后自动返回到应用。
        UIWebView *callWebView = [[UIWebView alloc]init];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebView];
        [callWebView release];
    }
    else
    {
        NSLog(@"取消");
    }
}


-(void)dealloc
{
    [_imgArray release];
    [_othersArray release];
    
    [super dealloc];
}

@end
