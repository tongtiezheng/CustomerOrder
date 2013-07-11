//
//  StoreLocationViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "StoreLocationViewController.h"
#import "CONST.h"
@interface StoreLocationViewController ()

@end

@implementation StoreLocationViewController

@synthesize mapView = _mapView;

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
    
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

    
    CGRect frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _mapView = [[BMKMapView alloc]initWithFrame:frame];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
   [self.view addSubview:_mapView];
    
    // 添加一个PointAnnotation
	BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
	CLLocationCoordinate2D coor;
	coor.latitude = 39.915;
	coor.longitude = 116.404;
    
	annotation.coordinate = coor;
    
	annotation.title = @"test";
	annotation.subtitle = @"this is a test!";
    
    // 跳转到用户位置
    [_mapView setCenterCoordinate:coor animated:YES];
    
	[_mapView addAnnotation:annotation];
    
    [annotation release];
}


#pragma mark -- BMKMapViewDelegate 
//加大头钉注释
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotation = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"]autorelease];
		newAnnotation.pinColor = BMKPinAnnotationColorPurple;
		newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = YES;
		
		return newAnnotation;
        
	}
	return nil;
}


- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)dealloc
{
    [_mapView release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
