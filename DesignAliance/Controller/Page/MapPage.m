//
//  MapPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MapPage.h"
#import "SearchMapPage.h"
#import "SearchModel.h"
#import "DASearchInfo.h"
#import "CustomAnnotationView.h"
#import <MapKit/MapKit.h>
#import "DetailsCompanyPage.h"
#import <AMapLocationKit/AMapLocationKit.h>


@interface MapPage() <MAMapViewDelegate, UIActionSheetDelegate, AMapLocationManagerDelegate>{

    NSMutableDictionary *companyInfo;
    
}
@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self configLocationManager]; //开启定位
    [self initMap];
    [self initData];
    //初始化储存公司信息的字典
    companyInfo = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self stopSerialLocation];
}

- (void)initData{
    
    NSString *body = [NSString stringWithFormat:@"pageSize=%d",10];
    NSDictionary *opInfo = @{@"url":SearchCompanyDefault,
                             @"body":body};
    
    _operation = [[DASearchInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(id)data{
    [super opSuccess:data];
    _pointArray = [[NSMutableArray alloc] init];
    for(SearchModel * s in data){
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(s.longitude.doubleValue, s.latitude.doubleValue);
        point.title = s.name;
        point.subtitle = s.desc;
        
        [companyInfo setObject:s forKey:point.title];
        
        [_pointArray addObject:point];
    }
    
    [_mapView addAnnotations:_pointArray];
}

- (void)initMap{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //设置缩放距离
    [_mapView setZoomLevel:14];
    //设置代理
    _mapView.delegate = self;
    //初始化点标记
    _pointAnnotation = [[MAPointAnnotation alloc] init];
}

#pragma 导航右键点击事件监听
- (void)doRight:(id)sender{
    
    SearchMapPage *page = [[SearchMapPage alloc] init];
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
}

//接受返回的参数
- (void)viewDidAppear:(BOOL)animated{
    //先删除原来的大头针
    //[_mapView removeAnnotations:_pointArray];
    
    if(!animated){
        return ;
    }
    
    CLLocationCoordinate2D coor;
    coor.latitude = self.search.longitude.doubleValue;
    coor.longitude =self.search.latitude.doubleValue;
    
    _pointAnnotation.coordinate = coor;
    _pointAnnotation.title = self.search.name;
    _pointAnnotation.subtitle = self.search.desc;
    _mapView.centerCoordinate = coor;
    
    [_mapView addAnnotation:_pointAnnotation];
    
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        
        static NSString * reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView * annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            
            annotationView.image = [UIImage imageNamed:@"mapMark"];
            ///设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -15);
            
            return annotationView;
        }
        
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    mapView.centerCoordinate = CLLocationCoordinate2DMake(view.annotation.coordinate.longitude,view.annotation.coordinate.latitude);
    self.search = [companyInfo objectForKey:view.annotation.title];
    BASE_INFO_FUN(view.annotation.title);
}

#pragma 标注气泡点击事件
- (void)butClick{
    DetailsCompanyPage *detailsCompanyPage = [[DetailsCompanyPage alloc] init];
    detailsCompanyPage.search = self.search;
    [self initToDetails:detailsCompanyPage];
}

#pragma Location delegate
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    self.locationManager.distanceFilter = 200; //设置定位最小更新距离方法
    
    [self startSerialLocation];
}

- (void)startSerialLocation
{
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}
#pragma 接收定位更新
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.longitude, location.coordinate.latitude, location.horizontalAccuracy);
}

@end
