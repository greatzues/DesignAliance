//
//  DAMission.m
//  DesignAliance
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAMission.h"
#import "MissionModel.h"

@implementation DAMission

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSArray *infos = [MissionModel arrayFromDict:dict];
    [_delegate opSuccess:infos];
}

@end
