//
//  LoginViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-13.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserInfo.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize customTV = _customTV;

@synthesize loginA = _loginA;
@synthesize shareA = _shareA;
@synthesize sectionA = _sectionA;
@synthesize shareImgA = _shareImgA;

@synthesize username = _username;
@synthesize pwd = _pwd;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//自定义导航栏上的按钮
- (void)customNavigationBtn
{
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //自定义导航栏右边这册按钮
    UIButton *rigntCollectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigntCollectBtn setFrame:CGRectMake(0, 0, 44, 34)];
    [rigntCollectBtn setImage:[UIImage imageNamed:@"signup_s@2x.png"] forState:UIControlStateNormal];
    [rigntCollectBtn addTarget:self action:@selector(startRegister) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigntCollectBar = [[UIBarButtonItem alloc]initWithCustomView:rigntCollectBtn];
    self.navigationItem.rightBarButtonItem = rigntCollectBar;
    [rigntCollectBar release];
    
}

//自定义返回按钮
- (void)backLeft
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//跳转到注册页
- (void)startRegister
{
    RegisterViewController *reg = [[RegisterViewController alloc]init];
    UINavigationController *regNa = [[UINavigationController alloc]initWithRootViewController:reg];
    [self presentViewController:regNa animated:YES completion:nil];
    [reg release];
    [regNa release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customNavigationBtn];
    
    
    _customTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _customTV.delegate = self;
    _customTV.dataSource = self;
    [self.customTV setBouncesZoom:NO];
    [self.customTV setBounces:NO];
    [self.view addSubview:_customTV];
    
    _loginA = [[NSArray alloc]initWithObjects:@"用户名",@"密   码", nil];
    _shareA = [[NSArray alloc]initWithObjects:@"用新浪微博账号登录",@"用QQ账号登录",@"用开心账号登录",@"用腾讯微博账号登录",@"用人人网账号登录", nil];
    
    _sectionA = [[NSArray alloc]initWithObjects:_loginA,_shareA, nil];
    
    UIImage *sinaImg = [UIImage imageNamed:@"ic_chk_sina_selected.png"];
    UIImage *qqImg = [UIImage imageNamed:@"qq.png"];
    UIImage *kaixinImg = [UIImage imageNamed:@"ic_chk_kaixin_selected@2x.png"];
    UIImage *chkImg = [UIImage imageNamed:@"ic_chk_qq_selected.png"];
    UIImage *renrenImg = [UIImage imageNamed:@"ic_chk_renren_selected.png"];
    
    _shareImgA = [[NSArray alloc]initWithObjects:sinaImg,qqImg,kaixinImg,chkImg,renrenImg, nil];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginBtn setFrame:CGRectMake(60, 115, 200, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"Button_0_D.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UILabel *other = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, 300, 20)];
    [other setText:@"没有点评账号？用其他账号登录"];
    [other setFont:[UIFont systemFontOfSize:14.0f]];
    [other setTextColor:[UIColor grayColor]];
    [other setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:other];
    [other release];
}

- (void)loginMethod
{
    
    if (_username.text == nil || _pwd == nil) {
            
        _username.text = @"";
        _pwd.text = @"";
           
    }
    
    //post提交的参数，格式如下：
    //参数1名字=参数1数据 & 参数2名字＝参数2数据 & 参数3名字＝参数3数据 & ...
    NSString *post = [NSString stringWithFormat:MEMBER_LOGIN_ARGUMENT,_username.text,_pwd.text];
    NSLog(@"post:%@",post);
        
    //将NSSrring格式的参数转换格式为NSData，POST提交必须用NSData数据
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    //计算POST提交数据的长度
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSLog(@"postLength=%@",postLength);
    //定义NSMutableURLRequest
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    //设置提交目的url
    [request setURL:[NSURL URLWithString:MEMBER_REGISTER_API]];
    //设置提交方式为 POST
    [request setHTTPMethod:@"POST"];
    //设置http-header:Content-Type
    //这里设置为 application/x-www-form-urlencoded ，如果设置为其它的，比如text/html;charset=utf-8，或者 text/html 等，都会出错
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //设置http-header:Content-Length
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //设置需要post提交的内容
    [request setHTTPBody:postData];
    //定义
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[[NSError alloc] init]autorelease];
    //同步提交:POST提交并等待返回值（同步），返回值是NSData类型
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:nil error:nil];
    NSLog(@"dic %@",dic);
    NSString *msg = [dic objectForKey:@"msg"];
    NSString *online_key = [dic objectForKey:@"online_key"];
    NSLog(@"online_key %@",online_key);
    
    [self alertView:msg];
    
    //保存用户名和密码到沙河
    [UserInfo savaLoginNameAndPwdWithName:_username.text andNameKey:@"username" pwd:_pwd.text andPwdKey:@"pwd"];
    //保存online_key
    [UserInfo savaOnline_keyValue:online_key andKey:@"online_key"];
}

        
//信登录息展示
- (void)alertView:(NSString *)msgInfo
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msgInfo delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_sectionA count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_sectionA objectAtIndex:section] count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
//    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    //    防止cell重用
    //    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    //
    //    for (UIView *subview in subviews) {
    //
    //        [subview removeFromSuperview];
    //
    //    }
    
    
    cell.textLabel.text = [[_sectionA objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (indexPath.section == 1) {
        
        cell.imageView.image = [_shareImgA objectAtIndex:indexPath.row];
        
    }
    
    
    if ((indexPath.section == 0)&&(indexPath.row == 0)) {
        
         _username = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, 240, 40)];
         _username.placeholder = @"email ，昵称，手机号";
         _username.delegate = self;
        [cell.contentView addSubview:_username];
        [_username release];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell不被选择
    }
    
    if ((indexPath.section == 0)&&(indexPath.row == 1)) {
        
         _pwd = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, 240, 40)];
         _pwd.placeholder = @"密码";
        [_pwd setSecureTextEntry:YES];
         _pwd.delegate = self;
        [cell.contentView addSubview:_pwd];
        [_pwd release];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell不被选择
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == 0||indexPath.row == 1)&& (indexPath.section == 0)) {
        return 40;
    }else
    {
        return 40;
        
    }
}

#pragma mark -- section 之间的距离
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    view.backgroundColor = [UIColor clearColor];
    return [view autorelease];
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    view.backgroundColor = [UIColor clearColor];
    return [view autorelease];
}


#pragma mark -- textField delegate
//点击键盘或return健是，软键盘收回
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


//#pragma mark 隐藏tabBar
//- (void)viewWillAppear: (BOOL)animated
//{
//    [self hideTabBar:YES];
//}
//- (void)viewWillDisappear: (BOOL)animated
//{
//    [self hideTabBar:NO];
//}
//
//- (void) hideTabBar:(BOOL) hidden
//{
//    for(UIView *view in self.tabBarController.view.subviews)
//    {
//        if([view isKindOfClass:[UITabBar class]])
//        {
//            if (hidden)
//            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+50, view.frame.size.width, view.frame.size.height)];
//            } else
//            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-50, view.frame.size.width, view.frame.size.height)];
//            }
//        }
//    }
//    UIView *superView=[self.tabBarController.view superview];
//    for(UIView *view in superView.subviews)
//    {
//        if([view isKindOfClass:[UIImageView class]])
//        {
//            if (hidden)
//            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+50, view.frame.size.width, view.frame.size.height)];
//                superView.frame=CGRectMake(0, 20, 320, 510);
//            } else
//            {
//                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-50, view.frame.size.width, view.frame.size.height)];
//                superView.frame=CGRectMake(0, 20, 320, 460);
//            }
//        }
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_loginA release];
    [_shareA release];
    [_sectionA release];
    [_shareImgA release];

    [_username release];
    [_pwd release];
    
    [super dealloc];
}
@end
