//
//  PersonCommentViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "PersonCommentViewController.h"
#import "UserInfo.h"

#define kMaxCharacterCount 100

@interface PersonCommentViewController ()

@end

@implementation PersonCommentViewController

@synthesize txtView = _txtView;
@synthesize mGrade =_mGrade;
@synthesize mAvmoney = _mAvmoney;

@synthesize fontCount = _fontCount;


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
    NSLog(@"提交评论");
    if (_txtView.text.length == 0 || _mGrade.text.length == 0 || _mAvmoney.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"不能提交" message:@"请输入评论" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
    }
    NSString *value = [UserInfo getOnline_keyValueWithKey:@"online_key"];
    NSLog(@"****value****%@",value);
    
    [self startJSONParserWithOnline_key:value shop_id:0 grade:0 avmoney:0 content:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self customNavigationBarButton];
    
    //评论内容
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(10, 140, 300, 140)];
    [_txtView setBackgroundColor:[UIColor orangeColor]];
    [_txtView setDelegate:self];
    [self.view addSubview:_txtView];
    
    
    //评论等级
    UILabel *gLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT - 44 - 20 - 50 - 400 , 100, 20)];
    [gLabel setText:@"等       级："];
    [self.view addSubview:gLabel];
    
    _mGrade = [[UITextField alloc]initWithFrame:CGRectMake(110, HEIGHT - 44 - 20 - 50 - 400 , 200, 25)];
    _mGrade.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_mGrade];
    
    
    //人均消费
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, HEIGHT - 44 - 20 - 50 - 360 , 100, 20)];
    [aLabel setText:@"人均消费："];
    [self.view addSubview:aLabel];
    
    _mAvmoney = [[UITextField alloc]initWithFrame:CGRectMake(110, HEIGHT - 44 - 20 - 50 - 360 , 200, 25)];
    _mAvmoney.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_mAvmoney];

    
    //字数限制
    _fontCount = [[UILabel alloc]initWithFrame:CGRectMake(145, 260, 160, 20)];
    [_fontCount setTextColor:[UIColor grayColor]];
    [_fontCount setBackgroundColor:[UIColor clearColor]];
    [_fontCount setText:[NSString stringWithFormat:@"你还可以输入%d字",kMaxCharacterCount]];
    [self.view addSubview:_fontCount];
    
}

//JSON 解析
- (void)startJSONParserWithOnline_key:(NSString *)online_key shop_id:(NSString *)shop_id grade:(float)grade
                              avmoney:(float)avmoney         content:(NSString *)content
{
    HD = [[[HTTPDownload alloc]init]autorelease];
    HD.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:PUBLISH_COMMENT_API];
    NSString *argument = [NSString stringWithFormat:PUBLISH_COMMENT_ARGUMENT,online_key,shop_id,grade,avmoney,content];
    NSLog(@"JSON解析 argument ---- >%@",argument);
    [HD downloadFromURL:urlStr withArgument:argument];
}


#pragma mark
#pragma mark -- HTTPDownloadDelegate Method
//下载完成
- (void)downloadDidFinishLoading:(HTTPDownload *)hd
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:HD.mData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"下载完成 dic **** >>%@",dic);
}

//下载失败
- (void)downloadDidFail:(HTTPDownload *)hd
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"下载失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
    
    NSLog(@"下载失败");
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
    }
    else
    {
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
    
    [super dealloc];

}

@end
