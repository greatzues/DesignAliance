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
#import <CRToast/CRToast.h>


@interface MapPage() <MAMapViewDelegate, UIActionSheetDelegate, AMapLocationManagerDelegate>
{
DetailsCompanyPage *detailsCompanyPage;
}
@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self initMap];
    [self initData];
    _companyInfo = [[NSMutableDictionary alloc] init];
    _pointArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    for(SearchModel * s in data){
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue);
        point.title = s.name;
        //point.subtitle = s.desc;
        //距离面积计算
        self.point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue));
        
        CLLocationDistance distance = MAMetersBetweenMapPoints(self.point1,self.point2);
        double dis = distance/1000;
        
        point.subtitle = [NSString stringWithFormat:@"距离您%f km",dis];
        
        [_companyInfo setObject:s forKey:point.title];
        
        [_pointArray addObject:point];
    }
    
    [_mapView addAnnotations:_pointArray];
}

- (void)initMap{
    [AMapServices sharedServices].enableHTTPS = YES;
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_mapView];
    
    [_mapView setZoomLevel:14];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    //初始化AMapLocationManager对象
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    _mapView.delegate = self;
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    
    //添加定位按钮，后期更换文字为图片
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    locationBtn.frame = CGRectMake(10, 10, 40, 40);//位置显示在顶部左边
    [locationBtn setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5]];
    [locationBtn setImage:[UIImage imageNamed:@"location.jpg"] forState:UIControlStateNormal];
    [locationBtn setTintColor:[UIColor whiteColor]];
    [locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapView addSubview:locationBtn];
    
    //开启定位
    [self locationClick];
}

#pragma 导航右键点击事件监听
- (void)doRight:(id)sender{
    SearchMapPage *page = [[SearchMapPage alloc] init];
    
    page.point1 = self.point1;
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
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
        }
        
        //显示当前经纬度
        if([annotationView.annotation.title isEqualToString:@"当前位置"]){
            annotationView.annotation.title = [NSString stringWithFormat:@"当前位置%f，%f",self.userLocation.coordinate.latitude,self.userLocation.coordinate.longitude];
            return nil;
        }
        annotationView.image = [UIImage imageNamed:@"mapMark.jpg"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -5);
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    mapView.centerCoordinate = CLLocationCoordinate2DMake(view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    [_mapView setZoomLevel:17.5 animated:YES];
    self.search = [_companyInfo objectForKey:view.annotation.title];
    BASE_INFO_FUN(view.annotation.title);
}

#pragma 标注气泡点击事件
- (void)butClick{
    detailsCompanyPage = [[DetailsCompanyPage alloc] init];
    detailsCompanyPage.search = self.search;
    [self initToDetails:detailsCompanyPage];
}

#pragma mark - 定位
- (void)locationClick
{
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
}
#pragma mark location fail
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    self.ToastTitle = @"自动定位异常，获取当前位置失败";
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    
                                }];
}

#pragma mark 用户位置更新
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        self.point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude));
        self.userLocation = userLocation;
        
    }
}

//这两个代理没效果
-(void)viewDidDisappear:(BOOL)animated{
    [self.locationManager stopUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.locationManager startUpdatingLocation];
}


@end
