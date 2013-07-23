//
//  RegisterViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "RegisterViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 30)];
    [userLabel setText:@"用  户  名："];
    [self.view addSubview:userLabel];
    [userLabel release];
    
    userField = [[[UITextField alloc]initWithFrame:CGRectMake(100, 20, 200, 30)]autorelease];
    [userField setBorderStyle:UITextBorderStyleRoundedRect];
    userField.delegate = self;
    [self.view addSubview:userField];
    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 200, 20)];
    [l1 setText:@"请输入用户名或邮箱"];
    [l1 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l1];
    [l1 release];
    
    //密码
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 100, 30)];
    [pwdLabel setText:@"密       码："];
    [self.view addSubview:pwdLabel];
    [pwdLabel release];
    pwdField = [[[UITextField alloc]initWithFrame:CGRectMake(100, 80, 200, 30)]autorelease];
    [pwdField setSecureTextEntry:YES];
    [pwdField setBorderStyle:UITextBorderStyleRoundedRect];
    pwdField.delegate = self;
    [self.view addSubview:pwdField];
    UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 110, 200, 20)];
    [l2 setText:@"请输入密码"];
    [l2 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l2];
    [l2 release];
    
    //确认密码
    UILabel *checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 100, 30)];
    [checkLabel setText:@"确认密码："];
    [self.view addSubview:checkLabel];
    [checkLabel release];
    
    ensurePwdField = [[[UITextField alloc]initWithFrame:CGRectMake(100, 140, 200, 30)]autorelease];
    [ensurePwdField setSecureTextEntry:YES];
    [ensurePwdField setBorderStyle:UITextBorderStyleRoundedRect];
    ensurePwdField.delegate = self;
    [self.view addSubview:ensurePwdField];
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 170, 200, 20)];
    [l3 setText:@"请确认密码"];
    [l3 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l3];
    [l3 release];
    
    
    //手机号码
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 100, 30)];
    [telLabel setText:@"手机号码："];
    [self.view addSubview:telLabel];
    [telLabel release];
    
    telField = [[[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 30)]autorelease];
    [telField setSecureTextEntry:YES];
    [telField setBorderStyle:UITextBorderStyleRoundedRect];
    telField.delegate = self;
    [self.view addSubview:telField];
    UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(100, 230, 200, 20)];
    [l4 setText:@"请输入手机号码"];
    [l4 setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:l4];
    [l4 release];
    
    //短信获取
    UIButton *obtainInfoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [obtainInfoBtn setFrame:CGRectMake(100, 260, 60, 30)];
    [obtainInfoBtn setTitle:@"获取短信" forState:UIControlStateNormal];
    [obtainInfoBtn setBackgroundImage:[UIImage imageNamed:@"Button_3_D_02.png"] forState:UIControlStateNormal];
    [obtainInfoBtn addTarget:self action:@selector(obtainInfoMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:obtainInfoBtn];
    
    infoEnsure = [[[UITextField alloc]initWithFrame:CGRectMake(160, 260, 140, 30)]autorelease];
    [infoEnsure setPlaceholder:@"请输入短信验证码"];
    [infoEnsure setBorderStyle:UITextBorderStyleLine];
    infoEnsure.delegate = self;
    [self.view addSubview:infoEnsure];
    
    UIImage *registerImg = [UIImage imageNamed:@"Button_0_D.png"];
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(20, 300, 280, 40)];
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
/*
    //表单提交前的验证
    if (userField.text == nil||pwdField.text == nil ) {
        
        NSLog(@"用户名或密码不能为空！");
        
        return;
    }
    
    
    NSURL *url = [NSURL URLWithString:MEMBER_REGISTER_API];
    NSLog(@"URL -- >>  %@",url);
   
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *urlStr = [NSString stringWithFormat:@"op=register&username=%@&userpwd=%@&repwd=%@&tel=%@&salt=%@",userField.text,pwdField.text,ensurePwdField.text,telField.text,infoEnsure.text];
    NSLog(@"**** %@",urlStr);
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
//    [request setPostBody:[NSMutableData dataWithData:[NSData dataWithData:data]]];
    
//    [request setPostValue:@"op=register" forKey:@"argument"];
    
    [request appendPostData:data];
    
//    [request setPostValue:userField.text forKey:@"username"];
//    [request setPostValue:pwdField.text forKey:@"password"];
//    [request setPostValue:ensurePwdField.text forKey:@"ensurePwdField"];
//    [request setPostValue:telField.text forKey:@"telField"];
//    [request setPostValue:infoEnsure.text forKey:@"infoEnsure"];
    
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
*/
    
    
    
    
    //post提交的参数，格式如下：
    //参数1名字=参数1数据&参数2名字＝参数2数据&参数3名字＝参数3数据&...
    NSString *post = [NSString stringWithFormat:@"op=register&username=%@&userpwd=%@&repwd=%@&tel=%@&salt=%@",userField.text,pwdField.text,ensurePwdField.text,telField.text,infoEnsure.text];    
    NSLog(@"post:%@",post);
    
    //将NSSrring格式的参数转换格式为NSData，POST提交必须用NSData数据。
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
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
    //这里设置为 application/x-www-form-urlencoded ，如果设置为其它的，比如text/html;charset=utf-8，或者 text/html 等，都会出错。不知道什么原因。
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //设置http-header:Content-Length
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //设置需要post提交的内容
    [request setHTTPBody:postData];
    
    //定义
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    //同步提交:POST提交并等待返回值（同步），返回值是NSData类型。
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //将NSData类型的返回值转换成NSString类型
    
    
//    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:result];
//    NSLog(@"%@",dic);
//    
//    NSLog(@"user login check result:%@",result);
    
    
    
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    NSString *msg = [dic objectForKey:@"msg"];
    int decide = [[dic objectForKey:@"code"] intValue];
    
   
    
    switch (decide) {
        case 0:
            [self alertView:msg];
            break;
        case 1:
            [self alertView:msg];
            break;
        case 2:
            [self alertView:msg];
            break;
        case 3:
            [self alertView:msg];
            break;
        case 4:
            [self alertView:msg];
            break;
        case 5:
            [self alertView:msg];
            break;
        case 6:
            [self alertView:msg];
            break;
        default:
            break;
    }
    
    
//    if ([@"success" compare:result]== NSOrderedSame)
//    {
//        return YES;
//    }
//    return NO;
    
    
}

- (void)alertView:(NSString *)msgInfo
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msgInfo delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];

    [alert release];
}

/*
//获取请求结果
- (void)GetResult:(ASIHTTPRequest *)request
{
    NSData *data =[request responseData];
    NSLog(@"****%@",data);
 
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];

       if ([dictionary objectForKey:@"yes"]) {

           NSLog(@"%@",dictionary);
           
           return;
           
    } else if ([dictionary objectForKey:@"error"] != [NSNull null]) {
        
        NSLog(@"nyh");
        
        return;
    }
}
//连接错误调用这个函数
- (void) GetErr:(ASIHTTPRequest *)request
{
    NSLog(@"连接错误！");
}
*/


//自定义返回按钮
- (void)backLeft
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击空白处时，软键盘收回
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![userField isExclusiveTouch]) {
        [userField resignFirstResponder];
    }
    if (![pwdField isExclusiveTouch]) {
        [pwdField resignFirstResponder];
    }
    if (![ensurePwdField isExclusiveTouch]) {
        [ensurePwdField resignFirstResponder];
    }
    if (![telField isExclusiveTouch]) {
        [telField resignFirstResponder];
    }
    if (![infoEnsure isExclusiveTouch]) {
        [infoEnsure resignFirstResponder];
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
