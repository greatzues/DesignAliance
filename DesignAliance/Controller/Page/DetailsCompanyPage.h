//
//  CompanyDetailsPage.h
//  DesignAliance
//
//  Created by zues on 17/5/12.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseDetailsPage.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SearchModel.h"


@interface DetailsCompanyPage : DABaseDetailsPage <MAMapViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *manager;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *location;

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;  //!< 要导航的坐标

@property(nonatomic, strong)   SearchModel          *search;
@property(nonatomic, strong)   MAMapView            *AmapView;
@property(nonatomic, strong)   MAUserLocation       *currentUserLoaction;
@property(nonatomic, strong)   MAPointAnnotation    *pointAnnotation;

@end
