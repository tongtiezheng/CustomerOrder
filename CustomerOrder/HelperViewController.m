//
//  HelperViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-26.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "HelperViewController.h"
#import "MainViewController.h"
#import "CONST.h"
@interface HelperViewController ()

@end

@implementation HelperViewController

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
    
//    UIView *aView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.view = aView;
//    [aView release];
    
    UIScrollView *aScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aScrollView.contentSize = CGSizeMake(320 * 5, HEIGHT);
    aScrollView.pagingEnabled = YES;
    aScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:aScrollView];
    for (int i = 0; i < 5; i++)
    {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, -20, WIDTH, HEIGHT)];
        [imgView setBackgroundColor:[UIColor whiteColor]];
        
        if (i == 0)
        {
            [imgView setImage:[UIImage imageNamed:@"fu1.jpg"]];
        }else if(i == 1)
        {
            [imgView setImage:[UIImage imageNamed:@"fu2.jpg"]];
        }else if(i == 2)
        {
            [imgView setImage:[UIImage imageNamed:@"fu3.jpg"]];
        }else if(i == 3)
        {
            [imgView setImage:[UIImage imageNamed:@"fu4.jpg"]];
        }else if(i == 4)
        {
            [imgView setImage:[UIImage imageNamed:@"fu5.jpg"]];
        }
        
        [aScrollView addSubview:imgView];
        [imgView release];
    }
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(1370, HEIGHT - 20 - 49 - 55 - 10, 155, 55)];
//    [btn setTitle:@"测试按钮" forState:UIControlStateNormal];
    [aScrollView addSubview:btn];
    [btn addTarget:self action:@selector(removeHelper) forControlEvents:UIControlEventTouchUpInside];
    [btn release];
    [aScrollView release];
    
}

- (void)removeHelper
{
    MainViewController *main = [[MainViewController alloc]init];
    [self presentViewController:main animated:YES completion:nil];
    [main release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
