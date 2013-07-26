//
//  PersonCommentViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "PersonCommentViewController.h"
#import "UserInfo.h"
#import "PostDataTools.h"

#define kMaxCharacterCount 100

@interface PersonCommentViewController ()

@end

@implementation PersonCommentViewController

@synthesize txtView = _txtView;
@synthesize mGrade =_mGrade;
@synthesize mAvmoney = _mAvmoney;

@synthesize fontCount = _fontCount;

@synthesize storeInfo = _storeInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)customNavigationBarButton
{
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
    [leftBtn setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //自定义导航栏右边的按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"CheckInIcon.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}

//自定义返回按钮
- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

//提交评论
- (void)commitComment
{
    if (_txtView.text.length == 0 || _mGrade.text.length == 0 || _mAvmoney.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入完整信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    
    NSString *storeid = [NSString stringWithFormat:@"%@",self.storeInfo.storeid];
    NSLog(@"----storeid----%@",storeid);
    NSString *online_key = [UserInfo getOnline_keyValueWithKey:@"online_key"];
    NSLog(@"****value****%@",online_key);
    
    
    if (_txtView.text.length != 0 && _mGrade.text.length != 0 && _mAvmoney.text.length != 0) {
    
        NSString *argument = [NSString stringWithFormat:PUBLISH_COMMENT_ARGUMENT,online_key,storeid,[_mGrade.text floatValue],[_mAvmoney.text floatValue],_txtView.text];
        
        NSLog(@"----------%@",argument);
        
        NSString *api = [NSString stringWithFormat:@"%@",PUBLISH_COMMENT_API];
        
        NSString *msg = [PostDataTools postDataWithPostArgument:argument andAPI:api];
    
        [self alertView:msg];
        
    }
}


//信息提示
- (void)alertView:(NSString *)msgInfo
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msgInfo delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self customNavigationBarButton];
    
    //评论等级
    UILabel *gLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT - 44 - 20  - 360 , 100, 20)];
    [gLabel setText:@"等       级："];
    [self.view addSubview:gLabel];
    [gLabel release];
    
    _mGrade = [[UITextField alloc]initWithFrame:CGRectMake(110, HEIGHT - 44 - 20  - 360 , 200, 25)];
    _mGrade.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_mGrade];
    
    
    //人均消费
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT - 44 - 20  - 320 , 100, 20)];
    [aLabel setText:@"人均消费："];
    [self.view addSubview:aLabel];
    [aLabel release];
    
    _mAvmoney = [[UITextField alloc]initWithFrame:CGRectMake(110, HEIGHT - 44 - 20  - 320 , 200, 25)];
    _mAvmoney.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_mAvmoney];

    //评论内容
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(10, HEIGHT - 44 - 20  - 275, 300, 140)];
    [_txtView setBackgroundColor:[UIColor orangeColor]];
    [_txtView setDelegate:self];
    [self.view addSubview:_txtView];

    
    //字数限制
    _fontCount = [[UILabel alloc]initWithFrame:CGRectMake(145, HEIGHT - 44 - 20 - 155, 160, 20)];
    [_fontCount setTextColor:[UIColor grayColor]];
    [_fontCount setBackgroundColor:[UIColor clearColor]];
    [_fontCount setText:[NSString stringWithFormat:@"你还可以输入%d字",kMaxCharacterCount]];
    [self.view addSubview:_fontCount];
    
}


//点击空白处键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![_txtView isExclusiveTouch]) {
        [_txtView resignFirstResponder];
    }
    
    if (![_mGrade isExclusiveTouch]) {
        [_mGrade resignFirstResponder];
    }
    
    if (![_mAvmoney isExclusiveTouch]) {
        [_mAvmoney resignFirstResponder];
    }
}


#pragma mark -- UITextView delegate 
- (void)textViewDidChange:(UITextView *)textView
{
	count = kMaxCharacterCount - [[_txtView text] length];
    [_fontCount setTextColor:[UIColor grayColor]];
	[_fontCount setText:[NSString stringWithFormat:@"你还可以输入%d字", count]];
    [_fontCount setTextAlignment:NSTextAlignmentRight];
	
	if(count == 0) {
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"已达输入字数上线" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
	}
	else if(count < 20) {
		
		[_fontCount setTextColor:[UIColor redColor]];
	}
	
}

//如果输入超过规定的字数100，就不再让输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location >= 100)
    {
        return  NO;
        
    } else {
        
        return YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [_txtView release];
    [_fontCount release];
    [_mGrade release];
    [_mAvmoney release];
    [_storeInfo release];
    
    [super dealloc];

}

@end
