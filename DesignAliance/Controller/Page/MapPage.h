//
//  MapPage.h
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"
#import "SearchModel.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface MapPage : DABasePage

@property(nonatomic, strong)   SearchModel          *search;
@property(nonatomic, strong)   MAMapView            *mapView;
@property(nonatomic, strong)   MAPointAnnotation    *pointAnnotation;
@property   MAMapPoint  point1;
@property   MAMapPoint  point2;

///用户位置
@property(nonatomic, strong)   MAUserLocation       *userLocation;

@property(nonatomic, strong)   NSMutableArray       *pointArray;
@property(nonatomic, strong)   NSMutableDictionary  *companyInfo;

@property(nonatomic, strong)   AMapLocationManager  *locationManager;

- (void)butClick;
- (void)locationClick;

@end
