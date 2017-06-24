//
//  DAGetAboutInfo.m
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAGetAboutInfo.h"
#import "AboutInfoModel.h"

@implementation DAGetAboutInfo

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetData];
    AboutInfoModel *infos = [AboutInfoModel infoFromDict:dictData];
    [_delegate opSuccess:infos];
}

@end
