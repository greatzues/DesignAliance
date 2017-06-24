//
//  SearchModel.m
//  DesignAliance
//
//  Created by zues on 17/4/30.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

+ (SearchModel *)infoFromDict:(NSDictionary *)dict{
    SearchModel *info = [[SearchModel alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    info.location = [dict objectForKey:@"location"];
    info.manager = [dict objectForKey:@"manager"];
    info.phone = [dict objectForKey:@"phone"];
    info.desc = [dict objectForKey:@"description"];
    info.latitude = [dict objectForKey:@"latitude"];
    info.longitude = [dict objectForKey:@"longitude"];
    
    info.businessConfirm = [dict objectForKey:@"businessConfirm"];
    info.locationConfirm = [dict objectForKey:@"locationConfirm"];
    
    return info;
}
//只接收返回dict中dataList的键值对
+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetDataList];
    return [[self class] arrayFromArray:array];
}
@end
