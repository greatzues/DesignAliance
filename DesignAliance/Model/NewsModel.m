//
//  NewsModel.m
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NewsModel *)infoFromDict:(NSDictionary *)dict{
    NewsModel *info = [[NewsModel alloc] init];
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"title"];
    info.cover = [dict objectForKey:@"cover"];
    info.link = [dict objectForKey:@"link"];
    info.content = [dict objectForKey:@"content"];
    info.time = [dict objectForKey:@"time"];
    
    return info;
}

+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetDataList];
    return [[self class] arrayFromArray:array];
}
@end
