//
//  CheckUpdateModel.m
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "CheckUpdateModel.h"

@implementation CheckUpdateModel

+ (CheckUpdateModel *)infoFromDict:(NSDictionary *)dict{
    CheckUpdateModel *info = [[CheckUpdateModel alloc] init];
    info.version = [dict objectForKey:@"version"];
    info.versionId = [dict objectForKey:@"id"];
    info.versionInfo = [dict objectForKey:@"info"];
    
    return info;
}

@end
