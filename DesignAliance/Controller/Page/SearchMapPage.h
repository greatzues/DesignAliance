//
//  SearchPage.h
//  DesignAliance
//
//  Created by zues on 17/5/1.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseSearchPage.h"
#import "SearchModel.h"
//#import "AdviserModel.h"
#import "MapPage.h"

@interface SearchMapPage : DABaseSearchPage

@property(nonatomic, strong) SearchModel    *model;
@property(nonatomic, strong) MapPage        *mapPage;

@property(nonatomic, strong)   NSMutableArray       *pointArray;
@property(nonatomic, strong)   NSMutableArray       *distanceArray;

@property(nonatomic, strong)   NSString *selectTitleUrl;
@property(nonatomic, strong)   NSString *selectTitleBody;

@property   MAMapPoint  point1;

@end
