//
//  AdvertisementModel.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "AdvertisementModel.h"

@implementation AdvertisementModel

+ (AdvertisementModel *)infoFromDict:(NSDictionary *)dict{
    AdvertisementModel *info = [[AdvertisementModel alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"issuer"];
    info.cover = [dict objectForKey:@"cover"];
    info.link = [dict objectForKey:@"link"];
    info.contact = [dict objectForKey:@"contact"];
    
    return info;
}
//重写父类的arrayFromDict方法，由于接口不统一，这里接收的数据由data改为datalist
+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetDataList];
    return [[self class] arrayFromArray:array];
}

@end
