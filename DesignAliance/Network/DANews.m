//
//  DANews.m
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DANews.h"
#import "NewsModel.h"

@implementation DANews

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSArray *infos = [NewsModel arrayFromDict:dict];
    [_delegate opSuccess:infos];
}

@end
