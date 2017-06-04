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

#import "RegisterPage.h"


@interface MapPage() <MAMapViewDelegate, UIActionSheetDelegate>

@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self initMap];
    [self initData];
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
    _pointArray = [NSMutableArray arrayWithCapacity:10];
    int i;
    for(i=0;i<[data count];i++){
        SearchModel  *s = [data objectAtIndex:i];
//        
//        //默认定位中心为返回的第一个返回的
//        if(i==0){
//            _mapView.centerCoordinate = CLLocationCoordinate2DMake(_search.longitude.doubleValue, _search.latitude.doubleValue);
//        }
//        
//        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(_search.longitude.doubleValue, _search.latitude.doubleValue);
//        _pointAnnotation.title = self.search.name;
//        _pointAnnotation.subtitle = self.search.desc;
//        [_pointArray addObject:_pointAnnotation];
        
        if(i==0){
            _mapView.centerCoordinate = CLLocationCoordinate2DMake(s.longitude.doubleValue, s.latitude.doubleValue);
        }
        
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(s.longitude.doubleValue, s.latitude.doubleValue);
        point.title = s.name;
        point.subtitle = s.desc;
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
    [_mapView setZoomLevel:12];
    //设置代理
    _mapView.delegate = self;
    //初始化点标记
    _pointAnnotation = [[MAPointAnnotation alloc] init];
}

#pragma 导航右键点击事件监听
- (void)doRight:(id)sender{
        //先删掉一组气泡
        [self.mapView removeAnnotation:_pointAnnotation];
    
        SearchMapPage *page = [[SearchMapPage alloc] init];
        page.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:page animated:YES];
}

//添加默认样式的点标记，即大头针
- (void) addPointAnnotationWithLatitude:(double)lati andLongitude:(double) longi Title:(NSString *) title Subtitle:(NSString *) subtitle
{
    
    _pointAnnotation.coordinate = CLLocationCoordinate2DMake(lati, longi);
    _pointAnnotation.title = title;
    _pointAnnotation.subtitle = subtitle;
    
    [self.mapView addAnnotation:_pointAnnotation];
}

//接受返回的参数
- (void)viewDidAppear:(BOOL)animated{
    //先删除原来的大头针
    [_mapView removeAnnotations:_pointArray];
    
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

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
}

#pragma 标注气泡点击事件
- (void)butClick{
    DetailsCompanyPage *detailsCompanyPage = [[DetailsCompanyPage alloc] init];
    detailsCompanyPage.search = self.search;
    [self initToDetails:detailsCompanyPage];
}

@end
