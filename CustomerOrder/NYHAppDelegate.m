//
//  NYHAppDelegate.m
//  CustomerOrder
//
//  Created by ios on 13-6-5.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "NYHAppDelegate.h"
#import "MainViewController.h"
#import "HelperViewController.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "UserInfo.h"

@implementation NYHAppDelegate

@synthesize mapManager = _mapManager;
@synthesize hostReach = _hostReach;
@synthesize viewDelegate = _viewDelegate;

- (void)dealloc
{
    [_window release];
    [_mapManager release];
    [_hostReach release];
    [_viewDelegate release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)init
{
    if(self = [super init])
    {
        _scene = WXSceneSession;
        _viewDelegate = [[AGViewDelegate alloc] init];
        
        //移除上次用户信息
        [UserInfo removeLoginNameAndPwdWithNameKey:@"username" andPwdKey:@"pwd"];
        //移除用户online_key
        [UserInfo removeOnline_keyValueWithKey:@"online_key"];
    }
    return self;
}


- (void)initializePlat
{
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3364763460" appSecret:@"30c7f48ba0cdbf19785bd5b83914f6f6"
                             redirectUri:@"http://open.weibo.com"];
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801379084" appSecret:@"c42487990fbf0ba28905a906956b22e9"
                                redirectUri:@"http://dev.t.qq.com/"];
    //添加人人网应用
    [ShareSDK connectRenRenWithAppKey:@"e0de735fa60f43858e64ac31b7db5ac5" appSecret:@"5e4fef8a998245f4a41103ac2c5d1236"];
    
    //添加微信应用
    [ShareSDK connectWeChatWithAppId:@"wxa87e471073449fde" wechatCls:[WXApi class]];
    
    //添加QQ应用
    [ShareSDK connectQQWithQZoneAppKey:@"100477745"qqApiInterfaceCls:[QQApiInterface class]tencentOAuthCls:[TencentOAuth class]];

    //添加QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"100477745" appSecret:@"68a428a919496c0a2ba4acd367a45b8e" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //开始监听网络
    [self startNotificationNetwork];
    
    //分享平台
    [ShareSDK registerApp:@"523d5e58594"];
    [self initializePlat];

    //设置导航视图
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"Helper"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path] == NO) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        HelperViewController *helper = [[HelperViewController alloc]init];
        [self.window setRootViewController:helper];
        [helper release];
    }
    else
    {
        MainViewController *main = [[MainViewController alloc]init];
        [self.window setRootViewController:main];
        [main release];
    }
    
    
    //启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，须设定generalDelegate参数
//    BOOL ret = [_mapManager start:@"2b21d1259156cd707d00a02f315afd00" generalDelegate:nil];
    BOOL ret = [_mapManager start:@"6BFC54B771E97D1DC21C36D71DC8C5F09FDEC65F" generalDelegate:nil];
    if (!ret){
        NSLog(@"manager start failed!");
    }
    
    //检查设备
    NSString* deviceType = [UIDevice currentDevice].model;
    NSLog(@"deviceType = %@", deviceType);
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


//处理连接改变后的情况,对连接改变做出响应的处理动作
- (void)updateInterfaceWithReachability:(Reachability *)curReach
{
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(status == NotReachable) {
        UIAlertView*alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                          message:@"网络连接失败,请检查网络"
                                                         delegate:nil
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    } else {
        
        NSLog(@"connect with the internet successfully!");
    }
}

// 连接改变
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}

//开始监听网络状态
-(void)startNotificationNetwork
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    _hostReach = [[Reachability reachabilityWithHostName:@"http://www.baidu.com"] retain];
    
    switch ([_hostReach currentReachabilityStatus])
    {
        case NotReachable:
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"正在使用wifi网络");
            break;
        default:
            break;
    }
    
    [_hostReach startNotifier];
}

//用于SSO客户端登录
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


@end
