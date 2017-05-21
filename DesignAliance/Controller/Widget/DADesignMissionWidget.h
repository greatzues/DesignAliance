//
//  DADesignMissionWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DATableWidget.h"
#import "CCCycleScrollView.h"


@interface DADesignMissionWidget : DATableWidget <CCCycleScrollViewClickActionDeleage>

@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;

@property (nonatomic, assign)BOOL              getAD;
@property (nonatomic, strong)NSMutableArray    *AdlistData;

@end
