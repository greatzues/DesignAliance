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



@interface MapPage() <MAMapViewDelegate, UIActionSheetDelegate>
{
    NSMutableDictionary *companyInfo;
}
@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self initMap];
    [self initData];
    companyInfo = [[NSMutableDictionary alloc] init];
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
    _pointArray = [[NSMutableArray alloc] init];
    for(SearchModel * s in data){
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue);
        point.title = s.name;
        point.subtitle = s.desc;
        
        [companyInfo setObject:s forKey:point.title];
        
        [_pointArray addObject:point];
    }
    
    [_mapView addAnnotations:_pointArray];
}

- (void)initMap{
    [AMapServices sharedServices].enableHTTPS = YES;
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_mapView];
    
    [_mapView setZoomLevel:14];
    
//    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
//    
//    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 60);  //设置比例尺位置
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    
    //添加定位按钮，后期更换文字为图片
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    locationBtn.frame = CGRectMake(10, 10, 60, 40);//位置显示在顶部左边
    [locationBtn setTitle:@"定位" forState:UIControlStateNormal];
    [locationBtn setBackgroundColor:[UIColor blackColor]];
    [locationBtn setTintColor:[UIColor whiteColor]];
    [locationBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:locationBtn];
    
    //开启定位
    [self locationClick];
}

#pragma 导航右键点击事件监听
- (void)doRight:(id)sender{
    SearchMapPage *page = [[SearchMapPage alloc] init];
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
}

////接受返回的参数
//- (void)viewDidAppear:(BOOL)animated{
//    
//    if(!animated){
//        return ;
//    }
//
//}

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
        
        annotationView.image = [UIImage imageNamed:@"mapMark"];
        ///设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -15);
        
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    mapView.centerCoordinate = CLLocationCoordinate2DMake(view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    [_mapView setZoomLevel:17.5 animated:YES];
    self.search = [companyInfo objectForKey:view.annotation.title];
    BASE_INFO_FUN(view.annotation.title);
}

#pragma 标注气泡点击事件
- (void)butClick{
    DetailsCompanyPage *detailsCompanyPage = [[DetailsCompanyPage alloc] init];
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
    [self alertView:@"定位错误，请检查网络后重试"];
}

@end
