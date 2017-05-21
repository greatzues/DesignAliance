//
//  DAMissionCell.m
//  DesignAliance
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DesignMissionCell.h"
#import "MissionModel.h"

@implementation DesignMissionCell

- (void)initCell{
    [super initCell];
}

- (void)dealloc
{
    RemoveNofify;
}

- (void)setCellData:(MissionModel *)info
{
    [super setCellData:info];
    
    _descLabel.numberOfLines = 2;
    _descLabel.text = info.count.stringValue; //到时再显示时间
    
}

@end
