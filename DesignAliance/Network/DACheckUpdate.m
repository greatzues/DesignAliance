//
//  DACheckUpdate.m
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DACheckUpdate.h"
#import "CheckUpdateModel.h"

@implementation DACheckUpdate

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetData];
    CheckUpdateModel *infos = [CheckUpdateModel infoFromDict:dictData];
    [_delegate opSuccess:infos];
}

@end
