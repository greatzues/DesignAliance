//
//  DABaseModel.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@implementation DABaseModel

+ (instancetype)infoFromDict:(NSDictionary *)dict{
    DABaseModel *info = [[DABaseModel alloc] init];
    
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    
    return info;
}

+ (NSArray *)arrayFromDict:(NSDictionary *)dict{
    NSArray *array = [dict objectForKey:NetData];
    return [[self class] arrayFromArray:array];
}

+ (NSArray *)arrayFromArray:(NSArray *)array{
    NSMutableArray *infos = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in array) {
        [infos addObject:[[self class] infoFromDict:dict]];
    }
    
    if (infos.count <= 0) {
        infos = nil;
    }
    
    return infos;
}

- (NSComparisonResult)compare:(DABaseModel *)bInfo{
    return [self.ID caseInsensitiveCompare:bInfo.ID];
}

- (BOOL)isEqual:(DABaseModel *)bInfo{
    return [self.ID isEqualToString:bInfo.ID];
}

@end
