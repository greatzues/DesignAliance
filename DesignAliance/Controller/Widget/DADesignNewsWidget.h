//
//  DADesignNewsWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DATableWidget.h"
#import "NewsModel.h"
#import "SDCycleScrollView.h"

@interface DADesignNewsWidget : DATableWidget <SDCycleScrollViewDelegate>

@property(nonatomic, strong)   NewsModel          *search;

@property (nonatomic, strong)SDCycleScrollView  *cycleScrollView;
@property (nonatomic, assign)BOOL               getAD;
@property (nonatomic, strong)NSMutableArray     *AdlistData;

@end
