//
//  PersonCommentViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "PersonCommentViewController.h"
#import "StoreList.h"
#import "UserInfo.h"
#import "PostDataTools.h"

#define kMaxCharacterCount 100

@interface PersonCommentViewController ()

@end

@implementation PersonCommentViewController
@synthesize txtView = _txtView;
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
    
    //自定义导航栏右边提交评论的按钮
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
    NSString *storeid = [NSString stringWithFormat:@"%@",self.storeInfo.storeid];
    NSString *online_key = [UserInfo getOnline_keyValueWithKey:@"online_key"];
    NSLog(@"****value****%@",online_key);
    
    
    if (grade && _mAvmoney.text.length != 0 && _txtView.text.length != 0) {
    
        NSString *argument = [NSString stringWithFormat:PUBLISH_COMMENT_ARGUMENT,online_key,storeid,grade,[_mAvmoney.text floatValue],_txtView.text];
    
        NSString *api = [NSString stringWithFormat:@"%@",PUBLISH_COMMENT_API];
        
        NSString *msg = [PostDataTools postDataWithPostArgument:argument andAPI:api];
    
        [self alertView:msg];
        
    } else if (!grade) {
    
        [self alertView:@"请输入评论等级"];
        
    } else if (_mAvmoney.text.length == 0) {
    
        [self alertView:@"请输入个人消费"];
        
    } else if (_txtView.text.length == 0) {
        
        [self alertView:@"请输入评论内容"];    
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
    
    
    imgNormal = [UIImage imageNamed:@"MyFavorite_X.png"];
    imgPress = [UIImage imageNamed:@"MyFavorite.png"];
    
    //调用评论等级方法
    [self commentGradeSelect];
    
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

//评论等级选择
- (void)commentGradeSelect
{
    
//    for (int i = 0; i < 5; i++) {
//        
//        imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [imgBtn setFrame:CGRectMake(120 + i * 40, HEIGHT - 44 - 20 - 360 - 35, 25, 25)];
//        [imgBtn setImage:[UIImage imageNamed:@"MyFavorite_X.png"] forState:UIControlStateNormal];
//        imgBtn.tag = i + 1;
//        [imgBtn addTarget:self action:@selector(selectGrade:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:imgBtn];
//    }
    
    imgBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn1 setFrame:CGRectMake(120 , HEIGHT - 44 - 20 - 360, 25, 25)];
    [imgBtn1 setImage:imgNormal forState:UIControlStateNormal];
    imgBtn1.tag = 1;
    [imgBtn1 addTarget:self action:@selector(selectGrade:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn1];

    imgBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn2 setFrame:CGRectMake(120 + 40, HEIGHT - 44 - 20 - 360, 25, 25)];
    [imgBtn2 setImage:imgNormal forState:UIControlStateNormal];
    imgBtn2.tag = 2;
    [imgBtn2 addTarget:self action:@selector(selectGrade:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn2];
    
    imgBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn3 setFrame:CGRectMake(120 + 40 * 2 , HEIGHT - 44 - 20 - 360, 25, 25)];
    [imgBtn3 setImage:imgNormal forState:UIControlStateNormal];
    imgBtn3.tag = 3;
    [imgBtn3 addTarget:self action:@selector(selectGrade:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn3];
    
    imgBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn4 setFrame:CGRectMake(120 + 40 * 3 , HEIGHT - 44 - 20 - 360, 25, 25)];
    [imgBtn4 setImage:imgNormal forState:UIControlStateNormal];
    imgBtn4.tag = 4;
    [imgBtn4 addTarget:self action:@selector(selectGrade:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn4];
    
    imgBtn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn5 setFrame:CGRectMake(120 + 40 * 4 , HEIGHT - 44 - 20 - 360, 25, 25)];
    [imgBtn5 setImage:imgNormal forState:UIControlStateNormal];
    imgBtn5.tag = 5;
    [imgBtn5 addTarget:self action:@selector(selectGrade:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn5];
    
}

//等级选择方法
- (void)selectGrade:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    switch (sender.tag) {
        case 1:
        
            [imgBtn1 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn2 setImage:imgNormal forState:UIControlStateNormal];
            [imgBtn3 setImage:imgNormal forState:UIControlStateNormal];
            [imgBtn4 setImage:imgNormal forState:UIControlStateNormal];
            [imgBtn5 setImage:imgNormal forState:UIControlStateNormal];
        
            grade = 1;
            
            break;
            
        case 2:
            
            [imgBtn1 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn2 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn3 setImage:imgNormal forState:UIControlStateNormal];
            [imgBtn4 setImage:imgNormal forState:UIControlStateNormal];
            [imgBtn5 setImage:imgNormal forState:UIControlStateNormal];
            
             grade = 2;
            
            break;
            
        case 3:
            
            [imgBtn1 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn2 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn3 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn4 setImage:imgNormal forState:UIControlStateNormal];
            [imgBtn5 setImage:imgNormal forState:UIControlStateNormal];
            
            grade = 3;
            
            break;
            
        case 4:
            
            [imgBtn1 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn2 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn3 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn4 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn5 setImage:imgNormal forState:UIControlStateNormal];

            grade = 4;
            
            break;
            
        case 5:
            
            [imgBtn1 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn2 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn3 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn4 setImage:imgPress forState:UIControlStateNormal];
            [imgBtn5 setImage:imgPress forState:UIControlStateNormal];

            grade = 5;
            
            break;
            
        default:
            break;
    }
}


//点击空白处键盘消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![_txtView isExclusiveTouch]) {
        [_txtView resignFirstResponder];
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
    [_mAvmoney release];
    [_storeInfo release];
    
    [super dealloc];

}

@end
