//
//  MainViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-13.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "NearbyViewController.h"
#import "MyOrderViewController.h"
#import "MoreViewController.h"

#define BOUNDS_HEIGHT [UIScreen mainScreen].bounds.size.height - 65

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize item1 = _item1;
@synthesize item2 = _item2;
@synthesize item3 = _item3;
@synthesize item4 = _item4;
@synthesize tab = _tab;

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
    
    [self configureTabBar];
    
    /*用来修改tabBar*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(hiddenTabBar) name:@"hiddenTabBar" object:nil];
    /*用来修改返回 MainViewController tabBar*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(displayTabBar) name:@"displayTabBar" object:nil];
//    /*用来修改历史记录页面*/
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self selector:@selector(update) name:@"update3" object:nil];
    
}

/*隐藏tabBar图像*/
- (void)hiddenTabBar
{
    NSTimeInterval animationDuration = 0.01f;
    [UIView beginAnimations:@"ResignzeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.item1.frame = CGRectMake(-24-320,  BOUNDS_HEIGHT,32 , 32);
    self.item2.frame = CGRectMake(-104-320, BOUNDS_HEIGHT,32 , 32);
    self.item3.frame = CGRectMake(-184-320, BOUNDS_HEIGHT,32 , 32);
    self.item4.frame = CGRectMake(-264-320, BOUNDS_HEIGHT,32 , 32);
    
//    [self.item1 setHidden:YES];
//    [self.item2 setHidden:YES];
//    [self.item3 setHidden:YES];
//    [self.item4 setHidden:YES];
    
    [UIView commitAnimations];
}

/*返回MainViewController时显示tabBar*/
- (void)displayTabBar
{
    NSTimeInterval animationDuration = 0.01;
    [UIView beginAnimations:@"ResignzeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.item1.frame = CGRectMake(24,  BOUNDS_HEIGHT,32 , 32);
    self.item2.frame = CGRectMake(104, BOUNDS_HEIGHT,32 , 32);
    self.item3.frame = CGRectMake(184, BOUNDS_HEIGHT,32 , 32);
    self.item4.frame = CGRectMake(264, BOUNDS_HEIGHT,32 , 32);
    
//    [self.item1 setHidden:NO];
//    [self.item2 setHidden:NO];
//    [self.item3 setHidden:NO];
//    [self.item4 setHidden:NO];

    [UIView commitAnimations];
}

///*跳转到历史页面*/
//- (void)update
//{
//    [self configureTabBar];
//    self.tab.selectedIndex = 1;
//    self.item1.image=[UIImage imageNamed:@"MyProfile_Book_X@2x.png"];
//    self.item3.image=[UIImage imageNamed:@"TabTuanSelected@2x.png"];
//}


//自定义tabBar
- (void)configureTabBar
{
    HomeViewController *home = [[HomeViewController alloc]init];
    UINavigationController *homeNa = [[UINavigationController alloc]initWithRootViewController:home];
    [home release];
    homeNa.tabBarItem.title = @"首页";
       
    
    NearbyViewController *nearby = [[NearbyViewController alloc]init];
    UINavigationController *nearbyNa = [[UINavigationController alloc]initWithRootViewController:nearby];
    [nearby release];
    nearbyNa.tabBarItem.title = @"附近商户";
   
    
    MyOrderViewController *myOrder = [[MyOrderViewController alloc]init];
    UINavigationController *myOrderNa = [[UINavigationController alloc]initWithRootViewController:myOrder];
    [myOrder release];
    myOrderNa.tabBarItem.title = @"我的预订";
   
    
    MoreViewController *more = [[MoreViewController alloc]init];
    UINavigationController *moreNa = [[UINavigationController alloc]initWithRootViewController:more];
    [more release];
    moreNa.tabBarItem.title = @"更多";
       
    _tab = [[UITabBarController alloc]init];
    _tab.viewControllers = [NSArray arrayWithObjects:homeNa,nearbyNa,myOrderNa,moreNa,nil];
    [homeNa release];
    [nearbyNa release];
    [myOrderNa release];
    [moreNa release];
    _tab.delegate = self;
    _tab.selectedIndex = 0;
   
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:_tab.view];
    [self addItemImgView];
}

- (void)addItemImgView
{
     _item1 = [[UIImageView alloc]initWithFrame:CGRectMake(24,BOUNDS_HEIGHT, 32, 32)];
    _item1.image = [UIImage imageNamed:@"MyProfile_Book@2x.png"];
    [_tab.view addSubview:_item1];
    
    _item2 = [[UIImageView alloc]initWithFrame:CGRectMake(104,BOUNDS_HEIGHT, 32, 32)];
    _item2.image = [UIImage imageNamed:@"TabMe@2x.png"];
    [_tab.view addSubview:_item2];
        
    _item3 = [[UIImageView alloc]initWithFrame:CGRectMake(184,BOUNDS_HEIGHT,32 ,32)];
    _item3.image = [UIImage imageNamed:@"TabTuan@2x.png"];
    [_tab.view addSubview:_item3];
    
    _item4 = [[UIImageView alloc]initWithFrame:CGRectMake(264,BOUNDS_HEIGHT,32, 32)];
    _item4.image = [UIImage imageNamed:@"TabMore@2x.png"];
    [_tab.view addSubview:_item4];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    switch (tabBarController.selectedIndex)
    {
        case 0:
        {
            _item1.image = [UIImage imageNamed:@"MyProfile_Book@2x.png"];
            _item2.image = [UIImage imageNamed:@"TabMe@2x.png"];
            _item3.image = [UIImage imageNamed:@"TabTuan@2x.png"];
            _item4.image = [UIImage imageNamed:@"TabMore@2x.png"];
            
        }
            break;
            
        case 1:
        {
            _item1.image = [UIImage imageNamed:@"MyProfile_Book_X@2x.png"];
            _item2.image = [UIImage imageNamed:@"TabMeSelected@2x.png"];
            _item3.image = [UIImage imageNamed:@"TabTuan@2x.png"];
            _item4.image = [UIImage imageNamed:@"TabMore@2x.png"];
            
        }
            break;
            
        case 2:
        {
            _item1.image = [UIImage imageNamed:@"MyProfile_Book_X@2x.png"];
            _item2.image = [UIImage imageNamed:@"TabMe@2x.png"];
            _item3.image = [UIImage imageNamed:@"TabTuanSelected@2x.png"];
            _item4.image = [UIImage imageNamed:@"TabMore@2x.png"];
            
        }
            break;
            
        case 3:
        {
            _item1.image = [UIImage imageNamed:@"MyProfile_Book_X@2x.png"];
            _item2.image = [UIImage imageNamed:@"TabMe@2x.png.png"];
            _item3.image = [UIImage imageNamed:@"TabTuan@2x.png"];
            _item4.image = [UIImage imageNamed:@"TabMoreSelected@2x.png"];
            
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_item1 release];
    [_item2 release];
    [_item3 release];
    [_item4 release];
    [_tab release];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"update1" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"update2" object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"update3" object:nil];

    [super dealloc];

}
@end
