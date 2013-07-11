//
//  RegisterViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "RegisterViewController.h"

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
    [pwdLabel setText:@"密        码："];
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
    
    
}

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
