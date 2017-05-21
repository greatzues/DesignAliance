//
//  MapPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MapPage.h"
#import "SearchPage.h"
#import "SearchModel.h"
#import "DASearchInfo.h"
#import "CustomAnnotationView.h"
#import <MapKit/MapKit.h>

#import "RegisterPage.h"


@interface MapPage() <MAMapViewDelegate, UIActionSheetDelegate>

@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self initMap];
    [self initData];
    
    //导航到深圳火车站,这是初始化导航终点
    //self.coordinate = CLLocationCoordinate2DMake(22.53183, 114.117206);
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
        _search = [data objectAtIndex:i];
        
        //默认定位中心为返回的第一个返回的
        if(i==0){
            _mapView.centerCoordinate = CLLocationCoordinate2DMake(_search.longitude.doubleValue, _search.latitude.doubleValue);
        }
        
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(_search.longitude.doubleValue, _search.latitude.doubleValue);
        _pointAnnotation.title = self.search.name;
        _pointAnnotation.subtitle = self.search.desc;
        [_pointArray addObject:_pointAnnotation];
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
    //设置代理
    _mapView.delegate = self;
    //初始化点标记
    _pointAnnotation = [[MAPointAnnotation alloc] init];
}

#pragma 导航右键点击事件监听
- (void)doRight:(id)sender{
        //先删掉一组气泡
        [self.mapView removeAnnotation:_pointAnnotation];
    
        SearchPage *page = [[SearchPage alloc] init];
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


//导航按钮动作
- (void)AMapNavigationAction{

    //系统版本高于8.0，使用UIAlertController
    if (IS_SystemVersionGreaterThanEight) {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"导航到设备" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //自带地图
        [alertController addAction:[UIAlertAction actionWithTitle:@"自带地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"alertController -- 自带地图");
            
            //使用自带地图导航
            MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
            
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
            
            [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                       MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
            
            
        }]];
        
        //判断是否安装了高德地图，如果安装了高德地图，则使用高德地图导航
        if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"alertController -- 高德地图");
                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
                
            }]];
        }
        
        //判断是否安装了百度地图，如果安装了百度地图，则使用百度地图导航
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"alertController -- 百度地图");
                NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
                
            }]];
        }
        
        //添加取消选项
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [alertController dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        
        //显示alertController
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else {  //系统版本低于8.0，则使用UIActionSheet
        
        UIActionSheet * actionsheet = [[UIActionSheet alloc] initWithTitle:@"导航到设备" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"自带地图", nil];
        
        //如果安装高德地图，则添加高德地图选项
        if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            
            [actionsheet addButtonWithTitle:@"高德地图"];
            
        }
        
        //如果安装百度地图，则添加百度地图选项
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
            
            [actionsheet addButtonWithTitle:@"百度地图"];
        }
        
        [actionsheet showInView:self.view];
        
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"numberOfButtons == %ld",actionSheet.numberOfButtons);
    NSLog(@"buttonIndex == %ld",buttonIndex);
    
    if (buttonIndex == 0) {
        
        NSLog(@"自带地图触发了");
        
        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
        
        [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                   MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        
    }
    //既安装了高德地图，又安装了百度地图
    if (actionSheet.numberOfButtons == 4) {
        
        if (buttonIndex == 2) {
            
            NSLog(@"高德地图触发了");
            
            NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
        }
        if (buttonIndex == 3) {
            
            NSLog(@"百度地图触发了");
            NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
        }
        
    }
    //安装了高德地图或安装了百度地图
    if (actionSheet.numberOfButtons == 3) {
        
        if (buttonIndex == 2) {
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
                
                NSLog(@"只安装的高德地图触发了");
                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coordinate.latitude,self.coordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
                
            }
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                NSLog(@"只安装的百度地图触发了");
                NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
            }
            
            
        }
        
    }
    
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"ActionSheet - 取消了");
    [actionSheet removeFromSuperview];
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

//监听选中气泡点击事件
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
}
//监听取消选中一个气泡事件
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    [mapView deselectAnnotation:_pointAnnotation animated:YES]; //调用上面那个方法
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"点击了查看详情");
}

//- (IBAction)toDeatils:(id)sender{
//    RegisterPage *page = [[RegisterPage alloc] init];
//    [self.navigationController pushViewController:page animated:YES];
//}

@end
