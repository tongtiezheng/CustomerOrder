//
//  ImgDetailViewController.m
//  CustomerOrder
//
//  Created by ios on 13-8-13.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "ImgDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "StoreList.h"
@interface ImgDetailViewController ()

@end

@implementation ImgDetailViewController
@synthesize storeList = _storeList;
@synthesize imgView = _imgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_imgView release];
    [super dealloc];
}

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
    
    //右边按钮
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonSystemItemEdit target:self action:@selector(saveImageToPhotos)];
    rightBtnItem.tintColor = [UIColor orangeColor];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    [rightBtnItem release];
}

//自定义返回按钮
- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存图片
- (void)saveImageToPhotos
{
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil;
    if(error != NULL) {
        
        msg = @"保存图片失败";
            
    } else {
        
        msg = @"保存图片成功";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alert show];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavigationBtn];
    
    //自定义导航栏标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleLabel.text = [NSString stringWithFormat:@"%@",self.storeList.name];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    self.imgView = imgView;
    [self.view addSubview:imgView];
    
    [imgView setImageWithURL:[NSURL URLWithString:self.storeList.pic] placeholderImage:nil];
    [imgView setFrame:CGRectMake((WIDTH - imgView.image.size.width)/2, (WIDTH - imgView.image.size.width)/2,imgView.image.size.width,imgView.image.size.height)];
    [imgView release];
}

//实现手势操作
//



- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenTabBar" object:nil];
    [self makeTabBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"displayTabBar" object:nil];
    [self makeTabBarHidden:NO];
}

//隐藏自定义tabBar
- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.tabBarController.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    
    
//    [UIView beginAnimations:@"TabbarHide" context:nil];
    
    if ( hide )
    {
        contentView.frame = self.tabBarController.view.bounds;
    }
    else
    {
        contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
                                       self.tabBarController.view.bounds.origin.y,
                                       self.tabBarController.view.bounds.size.width,
                                       self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    }
    
    self.tabBarController.tabBar.hidden = hide;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
