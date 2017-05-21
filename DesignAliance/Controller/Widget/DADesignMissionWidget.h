//
//  DADesignMissionWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DATableWidget.h"
#import "SDCycleScrollView.h"
#import "MissionModel.h"

@interface DADesignMissionWidget : DATableWidget <SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView  *cycleScrollView;
@property (nonatomic, assign)BOOL               getAD;
@property (nonatomic, strong)NSMutableArray     *AdlistData;

@property(nonatomic, strong)   MissionModel          *search;

@end
