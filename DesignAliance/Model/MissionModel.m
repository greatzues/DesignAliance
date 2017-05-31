//
//  MissionModel.m
//  DesignAliance
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MissionModel.h"

@implementation MissionModel

+ (MissionModel *)infoFromDict:(NSDictionary *)dict{
    MissionModel *info = [[MissionModel alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"title"];
    info.details = [dict objectForKey:@"details"];
    info.count = [dict objectForKey:@"count"];
    info.time = [dict objectForKey:@"time"];
    info.cover = [dict objectForKey:@"cover"];
    info.issuer = [dict objectForKey:@"issuer"];
    info.contact = [dict objectForKey:@"contact"];
    
    return info;
}
//重写父类的arrayFromDict方法，由于接口不统一，这里接收的数据由data改为datalist
+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetDataList];
    return [[self class] arrayFromArray:array];
}

@end
