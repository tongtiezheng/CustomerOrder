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
#import "NYHAppDelegate.h"
#import "ImgDetailViewController.h"


#import "CommentCell.h"
#import "CommentList.h"

#import "SetColor.h"
#import "StoreList.h"
#import "UIImageView+WebCache.h"
#import "DataBase.h"


@interface DetailViewController ()<DetailDisplayCellDelegate>

@end

@implementation DetailViewController

@synthesize imgArray = _imgArray;
@synthesize othersArray = _othersArray;


@synthesize appDelegate = _appDelegate;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize storeInfo = _storeInfo;
@synthesize HD = _HD;
@synthesize curpage = _curpage;
@synthesize mArray = _mArray;

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
    if ([[DataBase defaultDataBase]isExistItem:_storeInfo]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"记录已经存在！" delegate:self cancelButtonTitle:@"取消收藏" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        
    }else {
        
    [[DataBase defaultDataBase]insertItem:_storeInfo];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
    }
}

#pragma mark -- UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [[DataBase defaultDataBase]deleteItem:_storeInfo];
            break;
            
        default:
            break;
    }
}


//分享数据
- (void)shareData:(id)sender
{
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
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo,ShareTypeWeixiSession,ShareTypeSMS,ShareTypeQQ,ShareTypeQQSpace,ShareTypeTencentWeibo, nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo>
                                     error, BOOL end) {
                                
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
    [self.navigationController popViewControllerAnimated:YES];
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
    
    NSMutableArray *muArray = [[NSMutableArray alloc]init];
    self.mArray = muArray;
    [muArray release];
    
    //开始解析
    self.curpage = 0;
    [self startJSONParserWithCurpage:self.curpage shop_id:[self.storeInfo.storeid integerValue]];

    
    UIImage *addressImg = [UIImage imageNamed:@"Detail_AddressIcon.png"];
    UIImage *telImg = [UIImage imageNamed:@"Detail_PhoneIcon.png"];
    _imgArray = [[NSArray alloc]initWithObjects:addressImg,telImg, nil];
    _othersArray = [[NSArray alloc]initWithObjects:self.storeInfo.address,self.storeInfo.tel, nil];
    
    
//    //设置不让表格滑动
//    [self.tableView setBounces:NO];
    
}


//JSON 解析
- (void)startJSONParserWithCurpage:(int)cPage shop_id:(int)shop_id
{
    HTTPDownload *httpDownload = [[HTTPDownload alloc]init];
    httpDownload.delegate = self;
    self.HD = httpDownload;
    [httpDownload release];
    
    NSString *urlStr = [NSString stringWithFormat:GET_COMMENT_LIST_API];
    NSString *argument = [NSString stringWithFormat:GET_COMMENT_LIST_ARGUMENT,cPage,shop_id];
    
    [self.HD downloadFromURL:urlStr withArgument:argument];
    
}

#pragma mark
#pragma mark -- HTTPDownload delegate
- (void)downloadDidFinishLoading:(HTTPDownload *)hd
{  
    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:self.HD.mData options:nil error:nil];
    NSLog(@"--评论内容--%@",dic);
    
    if (dic != nil && [dic allKeys].count > 1) {
        
        NSLog(@"Detail 下载完成 curpage ---- >> %d",self.curpage);
        NSLog(@"Detail 下载完成 [dic allKeys].count ---- >> %d",[dic allKeys].count);
        
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
    return 4;
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
            cell.delegate = self;
        }
        
        cell.title.text = self.storeInfo.name;
        [cell.leftImgView setImageWithURL:[NSURL URLWithString:self.storeInfo.pic] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
        cell.average.text = self.storeInfo.avmoney;
        cell.description.text = self.storeInfo.description;
        
        float selectGrade = [self.storeInfo.grade floatValue];
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

        
        UIButton *order = [UIButton buttonWithType:UIButtonTypeCustom];
        [order setFrame:CGRectMake(245, 35, 80, 30)];
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
        }
        
        cell.imageView.image = [_imgArray objectAtIndex:indexPath.row - 1];
        cell.textLabel.text = [_othersArray objectAtIndex:indexPath.row - 1];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];

        //设置选中cell时的背景颜色
        [instance setCellBackgroundColor:cell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    } else {
        
        static NSString *CellIdentifier = @"CommentCell";
        CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        if ([self.mArray count] > 0) {
                
            CommentList *storeList = [self.mArray objectAtIndex:0];
                
            cell.average.text = storeList.avmoney;
            cell.content.text = storeList.content;
            cell.date.text = storeList.publish;
                
                
            float selectGrade = [storeList.grade floatValue];
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
                    
            } else {
                cell.sGrade.image = [UIImage imageNamed:nil];
            }
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 290, 20)];
            nameLabel.text = @"网友评论";
            nameLabel.textColor = [UIColor grayColor];
            nameLabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:nameLabel];
            [nameLabel release];

            
        } else {
            
                [cell.person setHidden:YES];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 290, HEIGHT - 44.f - 20.f - 50.f - 160.f - 48.f - 60.f - 20.f)];
                label.text = @"暂无评论内容";
                label.numberOfLines = 0;
                label.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:label];
                [label release];
            
        }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //设置点击cell时颜色
        [instance setCellBackgroundColor:cell];
        
        return cell;
    }
    
    
}

#pragma mark 
#pragma mark -- DetailDisplayCellDelegate 

- (void)selectLeftImgView:(DetailDisplayCell *)leftImgView
{
    ImgDetailViewController *imgDetail = [[ImgDetailViewController alloc]init];
    imgDetail.storeList = self.storeInfo;
    
//    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:imgDetail animated:YES];
    [imgDetail release];

}

- (void)orderSeat:(UIButton *)sender
{
    OrderViewController *order = [[OrderViewController alloc]init];
    order.oStoreInfo = self.storeInfo;
    [self.navigationController pushViewController:order animated:YES];
    [order release];
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 160.5;
    }
    
    if (indexPath.row == 1)
    {
        return 60;
    }
    
    if (indexPath.row == 3)
    {
        if (self.mArray != 0) {
            return 100.0f;
        } else {
        return HEIGHT - 44.f - 20.f - 50.f - 160.f - 48.f - 60.f;
        }
    }

    return 48.0f;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        StoreLocationViewController *storeLocation = [[StoreLocationViewController alloc]init];
        storeLocation.storeList = self.storeInfo;
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
        comment.storeInfo = self.storeInfo;
        
        [self.navigationController pushViewController:comment animated:YES];
        [comment release];
//        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark -- UIActionSheet delegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        NSString *telStr = [NSString stringWithFormat:@"tel://%@",[_othersArray objectAtIndex:1]];
        NSLog(@"%@",telStr);
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];//是用这种方式拨打电话，当用户结束通话后，iphone界面会停留在电话界面，用如下方式，可以使得用户结束通话后自动返回到应用。
        UIWebView *callWebView = [[UIWebView alloc]init];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebView];
        [callWebView release];
    
    } else {
        
        NSLog(@"取消");
    }
}


-(void)dealloc
{
    [_imgArray release];
    [_othersArray release];
    [_storeInfo release];
    [_HD release];
    [_mArray release];
    
    [super dealloc];
}

@end
