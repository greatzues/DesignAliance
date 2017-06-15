//
//  AdviserModel.m
//  DesignAliance
//
//  Created by zues on 2017/6/15.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "AdviserModel.h"

@implementation AdviserModel

+ (AdviserModel *)infoFromDict:(NSDictionary *)dict{
    AdviserModel *info = [[AdviserModel alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    info.type = [dict objectForKey:@"type"];
    info.location = [dict objectForKey:@"location"];
    info.phone = [dict objectForKey:@"phone"];
    info.desc = [dict objectForKey:@"description"];
    info.latitude = [dict objectForKey:@"latitude"];
    info.longitude = [dict objectForKey:@"longitude"];
    info.businessConfirm = [dict objectForKey:@"businessConfirm"];
    info.locationConfirm = [dict objectForKey:@"locationConfirm"];
    info.keyWord = [dict objectForKey:@"keyWord"];
    
    return info;
}
//重写父类的arrayFromDict方法，由于接口不统一，这里接收的数据由data改为datalist
+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetDataList];
    return [[self class] arrayFromArray:array];
}

@end
