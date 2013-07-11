//
//  PersonLocationViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-6.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "PersonLocationViewController.h"
#import "CONST.h"
#import "NYHAppDelegate.h"
@interface PersonLocationViewController ()

@end

@implementation PersonLocationViewController
@synthesize mapView = _mapView;
@synthesize search = _search;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
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

    //地图视图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    //POI检索 咖啡厅 
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performAction:) name:@"subLocality" object:nil];
    
}

- (void)performAction:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    NSString *name = [dic objectForKey:@"cityName"];
    cityName = name;
    NSLog(@"---- > %@",cityName);
    [self POISearchMethod];
}

//POI检索
- (void)POISearchMethod
{
    NSArray *array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    BOOL flag = [_search poiSearchInCity:cityName withKey:@"咖啡厅" pageIndex:0];
    if (!flag) {
        NSLog(@"search failed!");
    }
}

- (void)backRight
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- BMKMapViewDelegate
//用户位置更新后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil)
    {
        localLatitude = userLocation.location.coordinate.latitude; //获取纬度
        localLongitude = userLocation.location.coordinate.longitude; //获取经度
        
		NSLog(@"%f -- %f", localLatitude, localLongitude);
        

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
                           }
                           else if (error == nil && [placemarks count] == 0)
                           {
                               NSLog(@"No results were returned.");
                           }
                           else if (error != nil)
                           {
                               NSLog(@"An error occurred = %@", error);
                           }
                       }];
        [geocoder release];
        [location release];
        CLLocationCoordinate2D coordinate = _mapView.userLocation.location.coordinate;
        [self setMapRegionWithCoordinate:coordinate];
	}
}

//定位失败后，会调用此函数
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
    {
		NSLog(@"locate failed: %@", [error localizedDescription]);
    }
	else
    {
		NSLog(@"locate failed");
	}
}

//在地图View将要启动定位时，会调用此函数
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

//传入经纬度,将_mapView锁定到以当前经纬度为中心点的显示区域和合适的显示范围 
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKCoordinateRegion region;
    if (!_isSetMapSpan)//判断一下,只在第一次锁定显示区域时,设置一下显示范围 Map Region
    {
        region = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.15, 0.15));//比例尺越小，显示地图越详细
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_mapView release];
    [_search release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"subLocality" object:nil];
    [super dealloc];
}


@end


