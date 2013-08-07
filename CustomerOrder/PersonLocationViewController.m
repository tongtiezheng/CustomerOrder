//
//  PersonLocationViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "PersonLocationViewController.h"
#import "NYHAppDelegate.h"

@interface PersonLocationViewController ()

@end

@implementation PersonLocationViewController

@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

- (void)dealloc
{
    [_mapView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人位置";
    
    //自定义导航栏背景颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBg.png"] forBarMetrics:UIBarMetricsDefault];
    
    //重写右边边返回按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(backRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];

    //创建地图视图
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
}

#pragma mark -- 
#pragma mark -- MKMapViewDelegate 

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"用户位置：%f ---- %f",_mapView.userLocation.coordinate.latitude,_mapView.userLocation.coordinate.longitude);

    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(_mapView.userLocation.coordinate.latitude,_mapView.userLocation.coordinate.longitude);

    [self setMapRegionWithCoordinate:coords];
}


//传入经纬度,将_mapView锁定到以当前经纬度为中心点的显示区域和合适的显示范围
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region;
    if (!_isSetMapSpan)//判断一下,只在第一次锁定显示区域时,设置一下显示范围 Map Region
    {
        region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.008, 0.008));//比例尺越小，显示地图越详细
        _isSetMapSpan = YES;
        [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    }
    
    _currentSelectCoordinate = coordinate;
    
//    //跳转到用户位置
//    [_mapView setCenterCoordinate:coordinate animated:YES];
    
}

//地图区域改变完成后会调用此接口
//执行 setCenterCoordinate:coordinate 以后,开始移动,当移动完成后,会执此方法
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MKPointAnnotation *item = (MKPointAnnotation *)obj;
        if (item.coordinate.latitude == _currentSelectCoordinate.latitude && item.coordinate.longitude == _currentSelectCoordinate.longitude)
        {
            [_mapView selectAnnotation:obj animated:YES];//执行之后,会让地图中的标注处于弹出气泡框状态
            *stop = YES;
        }
    }];
}


- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}


- (void)backRight
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/* **** 

#pragma mark -- BMKMapViewDelegate
//用户位置更新后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil)
    {
        localLatitude = userLocation.location.coordinate.latitude; //获取纬度
        localLongitude = userLocation.location.coordinate.longitude; //获取经度
        
		NSLog(@"用户位置坐标：%f -- %f", localLatitude, localLongitude);
        
        
        //反向地理编码
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:localLatitude longitude:localLongitude];
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           
                           if (error == nil && [placemarks count] > 0)
                           {
                               for (CLPlacemark *placemark in placemarks)
                               {
                                   NSArray *subInfo = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
                                   info = [subInfo objectAtIndex:0];
                                   cityName = placemark.subLocality;
                                   
                                   NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:cityName,@"cityName", nil];
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"subLocality" object:nil userInfo:dic];
                                   [dic release];
                                   
                                   NSLog(@"1 - >%@",placemark.addressDictionary);
                                   NSLog(@"2 - >%@",info);
                                   NSLog(@"3 - >%@",cityName);
                               }
                               
                           } else if (error == nil && [placemarks count] == 0) {
                               
                               NSLog(@"No results were returned.");
                               
                           } else if (error != nil) {
                               
                               NSLog(@"An error occurred = %@", error);
                           }
                       }];
        [geocoder release];
        [location release];
        CLLocationCoordinate2D coordinate = _mapView.userLocation.location.coordinate;
        [self setMapRegionWithCoordinate:coordinate];
	}
}

//传入经纬度,将_mapView锁定到以当前经纬度为中心点的显示区域和合适的显示范围 
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKCoordinateRegion region;
    if (!_isSetMapSpan)//判断一下,只在第一次锁定显示区域时,设置一下显示范围 Map Region
    {
        region = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.01, 0.01));//比例尺越小，显示地图越详细
        _isSetMapSpan = YES;
        [_mapView setRegion:region animated:YES];
    }

    _currentSelectCoordinate = coordinate;
    //跳转到用户位置
   [_mapView setCenterCoordinate:coordinate animated:YES];

}

//地图区域改变完成后会调用此接口
//执行 setCenterCoordinate:coordinate 以后,开始移动,当移动完成后,会执此方法
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{    
    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BMKPointAnnotation *item = (BMKPointAnnotation *)obj;
        if (item.coordinate.latitude == _currentSelectCoordinate.latitude && item.coordinate.longitude == _currentSelectCoordinate.longitude)
        {
            [_mapView selectAnnotation:obj animated:YES];//执行之后,会让地图中的标注处于弹出气泡框状态
            *stop = YES;
        }
    }];
}

//POI检索
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	static NSString *AnnotationViewID = @"annotationViewID";
	
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
	annotationView.canShowCallout = TRUE;
    return annotationView;
}

//返回POI搜索结果
- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
	if (error == BMKErrorOk) {
		BMKPoiResult* result = [poiResultList objectAtIndex:0];
		for (int i = 0; i < result.poiInfoList.count; i++) {
			BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
			BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
			item.coordinate = poi.pt;
			item.title = poi.name;
			[_mapView addAnnotation:item];
			[item release];
		}
	}
}
**** */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end


