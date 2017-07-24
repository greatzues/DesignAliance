//
//  CompanyDetailsPage.m
//  DesignAliance
//
//  Created by zues on 17/5/12.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsCompanyPage.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotationView.h"
#import <CRToast/CRToast.h>

@implementation DetailsCompanyPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initMap];
    [self setTitle:self.search.name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMap{
    [AMapServices sharedServices].enableHTTPS = YES;
    
    _AmapView = [[MAMapView alloc] initWithFrame:self.mapView.bounds];
    
    [self.mapView addSubview:_AmapView];
    
    self.AmapView.showsScale = NO;
    self.AmapView.showsCompass = NO;
    
    [self.AmapView setZoomLevel:15];
    
    self.AmapView.scrollEnabled = NO;
    
    _AmapView.showsUserLocation = YES;
    _AmapView.userTrackingMode = MAUserTrackingModeFollow;
    
    _AmapView.delegate = self;
    
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    
    _pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.search.latitude.doubleValue, self.search.longitude.doubleValue);
    [_AmapView addAnnotation:_pointAnnotation];
    
    _AmapView.centerCoordinate = CLLocationCoordinate2DMake(self.search.latitude.doubleValue, self.search.longitude.doubleValue);
}

#pragma 初始化数据
- (void)initData{
    
    self.name.text    = self.search.name;
    
    self.desc.text    = self.search.desc;
    [self.phone setTitle:self.search.phone forState:UIControlStateNormal];
    if(self.search.manager){
        self.manager.text = self.search.manager;
        
        //放在这里是为了在显示设计顾问和技术顾问时候不出现认证图标
        NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
        if([userGrade isEqualToString:@"2"]){
            if([self.search.locationConfirm isEqualToString:@"1"]){
                self.locationConfirm.image = [UIImage imageNamed:@"DiLiRenZheng_heightlight.png"];
            }else{
                self.locationConfirm.image = [UIImage imageNamed:@"DiLiRenZheng.png"];
            }
            
            if([self.search.businessConfirm isEqualToString:@"1"]){
                self.businessConfirm.image = [UIImage imageNamed:@"GongShangRenZheng_heightlight.png"];
            }else{
                self.businessConfirm.image = [UIImage imageNamed:@"GongShangRenZheng.png"];
            }
        }
    }else{
        self.managerTitle.text = @"";
        self.manager.text = @"";
        self.phoneTitle.text = @"联系方式：";
    }
    
    
    self.location.text= self.search.location;
    self.location.numberOfLines = 0;   
    
    
    
    //初始化应用外导航的经纬度
    CLLocationCoordinate2D coor;
    coor.latitude = self.search.latitude.doubleValue;
    coor.longitude =self.search.longitude.doubleValue;
    self.coordinate = coor;
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
            
            if([annotationView.annotation.title isEqualToString:@"当前位置"]){
                return nil;
            }
            
            annotationView.image = [UIImage imageNamed:@"mapMark.jpg"];
            
            ///设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -15);
            
            return annotationView;
        }
        
    }
    return nil;
}

#pragma 气泡出现触发此事件
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    [self.AmapView deselectAnnotation:_pointAnnotation animated:YES];
}

#pragma 应用外导航
- (IBAction)AMapNavigationAction:(id)sender {
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
    
    NSLog(@"numberOfButtons == %ld",(long)actionSheet.numberOfButtons);
    NSLog(@"buttonIndex == %ld",(long)buttonIndex);
    
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

- (IBAction)contactUs:(id)sender {

    
    self.ToastTitle = @"正在调用通话功能，稍等片刻...";
    
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    UIWebView *callWebView = [[UIWebView alloc] init]; NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.search.phone]];
                                    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
                                    [self.view addSubview:callWebView];
                                }];
}

@end
