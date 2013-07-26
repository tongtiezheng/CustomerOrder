//
//  OrderViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "StoreList.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize tableView = _tableView;
@synthesize floorA = _floorA;

@synthesize seatView = _seatView;
@synthesize seatView2 = _seatView2;
@synthesize seatView3 = _seatView3;
@synthesize seatViewAll = _seatViewAll;

@synthesize oStoreInfo = _oStoreInfo;


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
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 44, 34)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

    //自定义导航栏右边刷新按钮
    UIButton *rigntCollectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigntCollectBtn setFrame:CGRectMake(0, 0, 44, 44)];
//    [rigntCollectBtn setImage:[UIImage imageNamed:@"common_titlebar_icon_favorite_off_rest@2x.png"] forState:UIControlStateNormal];
    [rigntCollectBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [rigntCollectBtn addTarget:self action:@selector(collectData:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigntCollectBar = [[UIBarButtonItem alloc]initWithCustomView:rigntCollectBtn];
    self.navigationItem.rightBarButtonItem = rigntCollectBar;
    [rigntCollectBar release];
    
}

//数据刷新
- (void)collectData:(id)dender
{
    NSLog(@"收藏成功");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"预订";
    [self customNavigationBtn];
    
    //自定义tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBounces:NO];//取消反弹效果
    [self.view addSubview:_tableView];
    

    _floorA = [[NSArray alloc]initWithObjects:@"一楼",@"二楼",@"三楼",@"全部", nil];
    //咖啡厅楼层选择
    for (int i = 0; i < 4; i++)
    {
        UIButton *floorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [floorBtn setBackgroundColor:[UIColor orangeColor]];
        [floorBtn setFrame:CGRectMake(i * 80, 100, 80, 40)];
        [floorBtn setTitle:[_floorA objectAtIndex:i] forState:UIControlStateNormal];
        floorBtn.tag = i;
        [floorBtn addTarget:self action:@selector(selectFloor:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:floorBtn];
    }
    
    //座位视图 默认为一楼座位
    _seatView = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 320, HEIGHT - 20 - 44 - 49 - 100)];
    [_seatView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:_seatView];
   
    for (int i = 1; i <= 3; i++) {
        for (int j = 1; j <= 3; j++) {
            UIButton *seatBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [seatBtn1 setBackgroundColor:[UIColor brownColor]];
            [seatBtn1 setFrame:CGRectMake(25*j+(j-1)*80, (i-1)*80, 60, 60)];
            [seatBtn1 addTarget:self action:@selector(seatOrder1:) forControlEvents:UIControlEventTouchUpInside];
            seatBtn1.tag = i+(j-1)*3;
            
            seatBtn1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            seatBtn1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            if (seatBtn1.tag <= 3) {
                [seatBtn1 setTitle:@"两人座\n  预订" forState:UIControlStateNormal];
            }else if(seatBtn1.tag <= 6)
            {
                [seatBtn1 setTitle:@"四人座\n  有人" forState:UIControlStateNormal];
                
            }else
            {
                [seatBtn1 setTitle:@"六人座\n  预订" forState:UIControlStateNormal];
            }
            
            [_seatView addSubview:seatBtn1];
        }
    }
}


//选者楼层方法
- (void)selectFloor:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            if (_seatView)
            {
                [_seatView removeFromSuperview];
            }
            if (_seatView2)
            {
                [_seatView2 removeFromSuperview];
            }
            if (_seatView3)
            {
                [_seatView3 removeFromSuperview];
            }
            if (_seatViewAll)
            {
                [_seatViewAll removeFromSuperview];
            }

            _seatView = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height - 40)];
            [_seatView setBackgroundColor:[UIColor orangeColor]];
            [self.view addSubview:_seatView];
           
            for (int i = 1; i <= 3; i++) {
                for (int j = 1; j <= 3; j++) {
                    UIButton *seatBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [seatBtn1 setBackgroundColor:[UIColor brownColor]];
                    [seatBtn1 setFrame:CGRectMake(25*j+(j-1)*80, (i-1)*80, 60, 60)];
                    [seatBtn1 addTarget:self action:@selector(seatOrder1:) forControlEvents:UIControlEventTouchUpInside];
                    seatBtn1.tag = i+(j-1)*3;
                    seatBtn1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
                    seatBtn1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    
                    if (seatBtn1.tag <= 3) {
                        [seatBtn1 setTitle:@"两人座\n  预订" forState:UIControlStateNormal];
                    }else if(seatBtn1.tag <= 6)
                    {
                        [seatBtn1 setTitle:@"四人座\n  有人" forState:UIControlStateNormal];
                    }else
                    {
                        [seatBtn1 setTitle:@"六人座\n  预订" forState:UIControlStateNormal];
                    }
                    
                    [_seatView addSubview:seatBtn1];
                }
            }
        }
            break;
            
        case 1:
        {
            if (_seatView)
            {
                [_seatView removeFromSuperview];
            }
            if (_seatView2)
            {
                [_seatView2 removeFromSuperview];
            }
            if (_seatView3)
            {
                [_seatView3 removeFromSuperview];
            }
            if (_seatViewAll)
            {
                [_seatViewAll removeFromSuperview];
            }

            _seatView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height - 40)];
            [_seatView2 setBackgroundColor:[UIColor orangeColor]];
            [self.view addSubview:_seatView2];
            
            for (int i = 1; i <= 2; i++) {
                for (int j = 1; j <= 3; j++) {
                    UIButton *seatBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [seatBtn2 setBackgroundColor:[UIColor brownColor]];
                    [seatBtn2 setFrame:CGRectMake(20*j+(j-1)*80, 10+(i-1)*110, 80, 80)];
                    seatBtn2.tag = i+(j-1)*2;
                    [seatBtn2 addTarget:self action:@selector(seatOrder2:) forControlEvents:UIControlEventTouchUpInside];
                    seatBtn2.titleLabel.font = [UIFont systemFontOfSize:20.0f];
                    seatBtn2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    
                    if (seatBtn2.tag <= 3) {
                        [seatBtn2 setTitle:@"两人座\n  预订" forState:UIControlStateNormal];
                    }
                    else
                    {
                        [seatBtn2 setTitle:@"四人座\n  有人" forState:UIControlStateNormal];
                    }

                    [_seatView2 addSubview:seatBtn2];
                    
                }
            }
        }
            break;
            
        case 2:
            
        {
            if (_seatView)
            {
                [_seatView removeFromSuperview];
            }
            if (_seatView2)
            {
                [_seatView2 removeFromSuperview];
            }
            if (_seatView3)
            {
                [_seatView3 removeFromSuperview];
            }
            if (_seatViewAll)
            {
                [_seatViewAll removeFromSuperview];
            }
            
            _seatView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height - 40)];
            [_seatView3 setBackgroundColor:[UIColor orangeColor]];
            [self.view addSubview:_seatView3];
            
            for (int i = 1; i <= 2; i++) {
                for (int j = 1; j <= 2; j++) {
                    UIButton *seatBtn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [seatBtn3 setBackgroundColor:[UIColor brownColor]];
                    [seatBtn3 setFrame:CGRectMake(40*j+(j-1)*100, (i-1)*110, 100, 100)];
                    seatBtn3.tag = i+(j-1)*2;
                    [seatBtn3 addTarget:self action:@selector(seatOrder3:) forControlEvents:UIControlEventTouchUpInside];
                    seatBtn3.titleLabel.font = [UIFont systemFontOfSize:24.0f];
                    seatBtn3.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
                    [seatBtn3 setTitle:@"两人座\n  预订" forState:UIControlStateNormal];
                
                    
                    [_seatView3 addSubview:seatBtn3];
                    
                }
            }
        }

            break;
            
        case 3:
            
            NSLog(@"全部");
        {
            if (_seatView)
            {
                [_seatView removeFromSuperview];
            }
            if (_seatView2)
            {
                [_seatView2 removeFromSuperview];
            }
            if (_seatView3)
            {
                [_seatView3 removeFromSuperview];
            }
            if (_seatViewAll)
            {
                [_seatViewAll removeFromSuperview];
            }
            
            _seatViewAll = [[UIView alloc]initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height - 40)];
            [_seatViewAll setBackgroundColor:[UIColor orangeColor]];
            [self.view addSubview:_seatViewAll];
            
            for (int i = 1; i <= 5; i++) {
                for (int j = 1; j <= 4; j++) {
                    UIButton *seatBtnAll = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [seatBtnAll setBackgroundColor:[UIColor brownColor]];
                    [seatBtnAll setFrame:CGRectMake(33*j+(j-1)*40, (i-1)*45, 40, 40)];
                    seatBtnAll.tag = i+(j-1)*5;
                    [seatBtnAll addTarget:self action:@selector(seatOrderAll:) forControlEvents:UIControlEventTouchUpInside];
                    [_seatViewAll addSubview:seatBtnAll];
                    
                    if (seatBtnAll.tag == 20)
                    {
                        [seatBtnAll setHidden:YES];
                    }
                    
                    [seatBtnAll  setTitle:@"座位" forState:UIControlStateNormal];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

//默认座位预订 即1楼座位选择
- (void)seatOrder1:(UIButton *)sender
{
    OrderDetailViewController *orderDetail = [[[OrderDetailViewController alloc]init]autorelease];
    NSLog(@"一楼%d",sender.tag);
    switch (sender.tag) {
        case 1:
//            orderDetail.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//            [self presentViewController:orderDetail animated:YES completion:^{}];
            [self.navigationController pushViewController:orderDetail animated:YES];
            break;
            
        case 2:
            
            [self.navigationController pushViewController:orderDetail animated:YES];
            
            break;
            
        default:
            break;
    }

}

- (void)seatOrder2:(UIButton *)sender
{
    OrderDetailViewController *orderDetail = [[[OrderDetailViewController alloc]init]autorelease];
    NSLog(@"二楼%d",sender.tag);
    switch (sender.tag) {
        case 1:
            [self.navigationController pushViewController:orderDetail animated:YES];
            break;
            
        default:
            break;
    }
    
}

- (void)seatOrder3:(UIButton *)sender
{
    OrderDetailViewController *orderDetail = [[[OrderDetailViewController alloc]init]autorelease];
    NSLog(@"三楼%d",sender.tag);
    switch (sender.tag) {
        case 1:
            [self.navigationController pushViewController:orderDetail animated:YES];
            break;
            
        default:
            break;
    }
    
}

- (void)seatOrderAll:(UIButton *)sender
{
    OrderDetailViewController *orderDetail = [[[OrderDetailViewController alloc]init]autorelease];
    NSLog(@"全部%d",sender.tag);
    switch (sender.tag) {
        case 1:
            
            [self.navigationController pushViewController:orderDetail animated:YES];
            
            break;
            
        default:
            break;
    }
    
}



//自定义返回按钮
- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    [rigntShareBtn setHidden:NO];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [rigntShareBtn setHidden:YES];
}


#pragma mark -- tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";

    OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    
//    cell.leftImgView.image = [UIImage imageNamed:@"4.jpg"];
//    cell.title.text = @"上地咖啡厅";
//    cell.description.text = @"本咖啡厅环境优美，欢迎惠顾 哈哈哈哈啊哈哈哈哈 再详细点 ";
    
    
    [cell.leftImgView setImageWithURL:[NSURL URLWithString:self.oStoreInfo.pic]];
    cell.title.text = self.oStoreInfo.name;
    cell.description.text = self.oStoreInfo.description;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
#pragma mark -- tableView delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_tableView release];
    [_floorA release];
    
    [_seatView release];
    [_seatView2 release];
    [_seatView3 release];
    [_seatViewAll release];
    
    [super dealloc];

}
@end
