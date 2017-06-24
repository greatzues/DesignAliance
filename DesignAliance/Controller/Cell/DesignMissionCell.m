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
    _descLabel.text = [NSString stringWithFormat:@"%@次浏览",info.count.stringValue];
    
    _timeLabel.text = [self dateToTime: info.time.stringValue];
    
}

@end
