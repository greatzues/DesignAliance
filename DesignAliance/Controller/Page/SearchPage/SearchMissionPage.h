//
//  SearchMissionPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseSearchPage.h"
#import "DADesignMissionWidget.h"
#import "MissionModel.h"

@interface SearchMissionPage : DABaseSearchPage

@property(nonatomic, strong) DADesignMissionWidget       *page;
@property(nonatomic, strong) MissionModel                *model;

@end
