//
//  DATalents.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DATalents.h"
#import "TalentsModel.h"

@implementation DATalents

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSArray *infos = [TalentsModel arrayFromDict:dict];
    [_delegate opSuccess:infos];
}


@end
