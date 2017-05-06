//
//  DASearchInfo.m
//  DesignAliance
//
//  Created by zues on 17/4/30.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DASearchInfo.h"
#import "SearchModel.h"

@implementation DASearchInfo

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSArray *infos = [SearchModel arrayFromDict:dict];
    [_delegate opSuccess:infos];
}

@end
