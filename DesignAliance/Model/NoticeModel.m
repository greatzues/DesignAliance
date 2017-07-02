//
//  NoticeModel.m
//  DesignAliance
//
//  Created by zues on 2017/7/1.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel

+ (NoticeModel *)infoFromDict:(NSDictionary *)dict{
    NoticeModel *info = [[NoticeModel alloc] init];
    info.userId = [dict objectForKey:@"userId"];
    info.adviceId = [dict objectForKey:@"adviceId"];
    info.missionId = [dict objectForKey:@"missionId"];
    info.personId = [dict objectForKey:@"persionId"];
    
    return info;
}

@end
