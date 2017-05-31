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

@interface MapPage : DABasePage

@property(nonatomic, strong)   SearchModel          *search;
@property(nonatomic, strong)   MAMapView            *mapView;
@property(nonatomic, strong)   MAUserLocation       *currentUserLoaction;
@property(nonatomic, strong)   MAPointAnnotation    *pointAnnotation;

@property(nonatomic, strong)   NSMutableArray       *pointArray;

- (void)butClick;

@end
