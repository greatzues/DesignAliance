//
//  TalentsModel.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "TalentsModel.h"

@implementation TalentsModel

+ (TalentsModel *)infoFromDict:(NSDictionary *)dict{
    TalentsModel *info = [[TalentsModel alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    info.sex = [dict objectForKey:@"sex"];
    info.phone = [dict objectForKey:@"phone"];
    info.avatar = [dict objectForKey:@"avatar"];
    info.skill = [dict objectForKey:@"skill"];
    info.education = [dict objectForKey:@"education"];
    info.desc = [dict objectForKey:@"description"];
    
    return info;
}
//重写父类的arrayFromDict方法，由于接口不统一，这里接收的数据由data改为datalist
+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetDataList];
    return [[self class] arrayFromArray:array];
}

@end
