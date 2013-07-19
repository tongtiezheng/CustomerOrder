//
//  StoreLocationViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-7.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "StoreLocationViewController.h"
#import "StoreList.h"
#import <MapKit/MapKit.h>
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface StoreLocationViewController ()

@end

@implementation StoreLocationViewController

@synthesize mapView = _mapView;
@synthesize storeList = _storeList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//自定义导航栏按钮
- (void)customNavagationButton
{
    //重写左边返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"NaviBack.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //重写右边返回按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"导航" forState:UIControlStateNormal];
    [rightBtn setShowsTouchWhenHighlighted:YES];
    [rightBtn addTarget:self action:@selector(backRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //导航栏按钮
    [self customNavagationButton];
    
    CGRect frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _mapView = [[BMKMapView alloc]initWithFrame:frame];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
   [self.view addSubview:_mapView];
    
    // 添加一个PointAnnotation
	BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
	CLLocationCoordinate2D coor;
	coor.latitude = [self.storeList.lat floatValue];
	coor.longitude = [self.storeList.lng floatValue];

	annotation.coordinate = coor;
    
	annotation.title = self.storeList.name;
	annotation.subtitle = self.storeList.address;
    
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

//返回按钮
- (void)backLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backRight
{
    
//    NSString *title = @"title";
//    float latitude = 35.4634;
//    float longitude = 9.43425;
//
//    int zoom = 13;
//    NSString *stringURL = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@@%1.6f,%1.6f&z=%d", title, latitude, longitude, zoom];
//    NSLog(@"%@",stringURL);
//    NSURL *url = [NSURL URLWithString:stringURL];
//    [[UIApplication sharedApplication] openURL:url];
    
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) { // ios6以下，调用google map
        
        NSString *urlString = [[NSString alloc]
                               initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",
                               _mapView.userLocation.location.coordinate.latitude,_mapView.userLocation.location.coordinate.longitude,[self.storeList.lat doubleValue],[self.storeList.lng doubleValue]];
        
        NSURL *aURL = [NSURL URLWithString:urlString];
        
        [urlString release];
        
        [[UIApplication sharedApplication] openURL:aURL];
        
    } else { // 直接调用ios自己带的apple map
    
        CLLocationCoordinate2D to;
        
        to.latitude = [self.storeList.lat floatValue];
        
        to.longitude = [self.storeList.lng floatValue];
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil] autorelease]];
        
        toLocation.name = self.storeList.name;
        
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
         
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                      
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
        
        [toLocation release];
        
    }
}


-(void)dealloc
{
    [_mapView release];
    [_storeList release];
    [super dealloc];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
