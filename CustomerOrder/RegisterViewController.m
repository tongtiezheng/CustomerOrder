//
//  RegisterViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"


#define Y HEIGHT - 44 - 20 - 20

@interface RegisterViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    MBProgressHUD *HUD;
    NSMutableData *_mData;
}

@end

@implementation RegisterViewController

@synthesize username = _username;
@synthesize userpwd = _userpwd;
@synthesize repwd = _repwd;
@synthesize tel = _tel;
@synthesize salt = _salt;


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

    self.title = @"用户注册";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

    //用户名
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Y - 360 - 30, 100, 30)];
    [userLabel setText:@"用  户  名："];
    [self.view addSubview:userLabel];
    [userLabel release];
    
     _username = [[[UITextField alloc]initWithFrame:CGRectMake(100, Y - 360 - 30, 200, 30)]autorelease];
    [_username setBorderStyle:UITextBorderStyleRoundedRect];
     _username.delegate = self;
    [self.view addSubview:_username];
    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(100, Y - 340 - 20, 200, 20)];
    [l1 setText:@"请输入用户名或邮箱"];
    [l1 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l1];
    [l1 release];
    
    //密码
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Y - 330, 100, 30)];
    [pwdLabel setText:@"密       码："];
    [self.view addSubview:pwdLabel];
    [pwdLabel release];
    
     _userpwd = [[[UITextField alloc]initWithFrame:CGRectMake(100, Y - 330, 200, 30)]autorelease];
    [_userpwd setSecureTextEntry:YES];
    [_userpwd setBorderStyle:UITextBorderStyleRoundedRect];
     _userpwd.delegate = self;
    [self.view addSubview:_userpwd];
    UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(100, Y - 300, 200, 20)];
    [l2 setText:@"请输入密码"];
    [l2 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l2];
    [l2 release];
    
    //确认密码
    UILabel *checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Y - 260, 100, 30)];
    [checkLabel setText:@"确认密码："];
    [self.view addSubview:checkLabel];
    [checkLabel release];
    
     _repwd = [[[UITextField alloc]initWithFrame:CGRectMake(100, Y - 260, 200, 30)]autorelease];
    [_repwd setSecureTextEntry:YES];
    [_repwd setBorderStyle:UITextBorderStyleRoundedRect];
     _repwd.delegate = self;
    [self.view addSubview:_repwd];
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(100, Y - 230, 200, 20)];
    [l3 setText:@"请确认密码"];
    [l3 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l3];
    [l3 release];
    
    //手机号码
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Y - 190, 100, 30)];
    [telLabel setText:@"手机号码："];
    [self.view addSubview:telLabel];
    [telLabel release];
    
     _tel = [[[UITextField alloc]initWithFrame:CGRectMake(100, Y - 190, 200, 30)]autorelease];
    [_tel setSecureTextEntry:YES];
    [_tel setBorderStyle:UITextBorderStyleRoundedRect];
     _tel.delegate = self;
    [self.view addSubview:_tel];
    UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(100, Y - 160, 200, 20)];
    [l4 setText:@"请输入手机号码"];
    [l4 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l4];
    [l4 release];
    
    //获取验证码
    UIButton *obtainInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [obtainInfoBtn setFrame:CGRectMake(100, Y - 120, 60, 30)];
    [obtainInfoBtn setTitle:@"获取短信" forState:UIControlStateNormal];
    [obtainInfoBtn setBackgroundImage:[UIImage imageNamed:@"Button_3_D_02.png"] forState:UIControlStateNormal];
    [obtainInfoBtn addTarget:self action:@selector(obtainInfoMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:obtainInfoBtn];
    
     _salt = [[[UITextField alloc]initWithFrame:CGRectMake(160, Y - 120, 140, 30)]autorelease];
    [_salt setPlaceholder:@"请输入短信验证码"];
    [_salt setBorderStyle:UITextBorderStyleLine];
     _salt.delegate = self;
    [self.view addSubview:_salt];
    
    
    UIImage *registerImg = [UIImage imageNamed:@"Button_0_D.png"];
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(20, Y - 60, 280, 40)];
    [registerBtn setBackgroundImage:registerImg forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(commitRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
}

//获取短信验证码
- (void)obtainInfoMethod
{
    
    
}


//注册方法
-(void)commitRegister
{
    if (_username.text == nil || _userpwd.text == nil) {
        
        _username.text = @"";
        _userpwd.text = @"";
        _repwd.text = @"";
        _tel.text = @"";
        _salt.text = @"";
    }
 
    //post提交的参数，格式如下：
    //参数1名字=参数1数据 & 参数2名字＝参数2数据 & 参数3名字＝参数3数据 & ...
    NSString *post = [NSString stringWithFormat:MEMBER_REGISTER_ARGUMENT,_username.text,_userpwd.text,_repwd.text,_tel.text,_salt.text];
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
    
//    //定义
//    NSHTTPURLResponse *urlResponse = nil;
//    NSError *error = [[[NSError alloc] init]autorelease];
//    //同步提交:POST提交并等待返回值（同步），返回值是NSData类型
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//    
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:nil error:nil];
//    NSLog(@"dic %@",dic);
//    NSString *msg = [dic objectForKey:@"msg"];
    
    
    //异步提交
    [NSURLConnection connectionWithRequest:request delegate:self];
    [self indicatorView];

}

#pragma mark -- 异步下载
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _mData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_mData options:nil error:nil];
    NSString *msg = [dic objectForKey:@"msg"];
    
    [self alertView:msg];
    
    [self hudWasHidden:HUD];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self alertView:@"注册失败"];
}


#pragma mark --
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


//注册信息展示
- (void)alertView:(NSString *)msgInfo
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msgInfo delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}


//自定义返回按钮
- (void)backLeft
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击空白处时，软键盘收回
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![_username isExclusiveTouch]) {
        [_username resignFirstResponder];
    }
    if (![_userpwd isExclusiveTouch]) {
        [_userpwd resignFirstResponder];
    }
    if (![_repwd isExclusiveTouch]) {
        [_repwd resignFirstResponder];
    }
    if (![_tel isExclusiveTouch]) {
        [_tel resignFirstResponder];
    }
    if (![_salt isExclusiveTouch]) {
        [_salt resignFirstResponder];
    }
}

#pragma mark -- textField delegate
//点击键盘或return健是，软键盘收回
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//点击textField时，textField往上移动
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = (self.view.frame.size.height - 216.0) - frame.origin.y - 32 ;//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset < 0)
    {
        self.view.frame = CGRectMake(0.0f, offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
