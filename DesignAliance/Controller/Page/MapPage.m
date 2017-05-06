//
//  MapPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MapPage.h"
#import "SearchPage.h"


@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self initMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMap{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)doRight:(id)sender{
        SearchPage *page = [[SearchPage alloc] init];
        [self.navigationController pushViewController:page animated:YES];
}
@end
