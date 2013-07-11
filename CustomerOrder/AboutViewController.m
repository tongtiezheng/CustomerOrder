//
//  AboutViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    UITextView *txtView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [self.view addSubview:txtView];

    txtView.text = @"\n本公司是一家集Internet网站建设，信息收集传播,宣传企业文化，软件开发为一体的信息技术开发公司。本公司致力于政府、企业、学校的系列解决方案。并承接各种软件、网站项目的制作和维护。同时也提供专业技术员、技术团队或技术顾问外包服务。\n\n\n服务宗旨：求实、创新、奋进 \n提供服务：网站制作/维护 系统/软件开发 网站优化 网站推广 \n联系人：曾超新 \n联系电话：13910284481 \n商家地址：北京-海淀-上地十街-1号院-4号楼-1715室 ";
    [txtView setFont:[UIFont systemFontOfSize:14.0f]];
    [txtView release];

    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

}

- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
