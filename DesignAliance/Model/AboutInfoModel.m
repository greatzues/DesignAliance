//
//  AboutInfoModel.m
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//



#import "AboutInfoModel.h"

@implementation AboutInfoModel

+ (AboutInfoModel *)infoFromDict:(NSDictionary *)dict{
    AboutInfoModel *info = [[AboutInfoModel alloc] init];
    info.brief = [dict objectForKey:@"brief"];
    info.slogan = [dict objectForKey:@"slogan"];
    info.target = [dict objectForKey:@"target"];
    info.phone = [dict objectForKey:@"phone"];
    info.member = [dict objectForKey:@"member"];
    info.guidance = [dict objectForKey:@"guidance"];
    
    return info;
}

@end
