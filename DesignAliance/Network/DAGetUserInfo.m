//
//  DAGetUserInfo.m
//  DesignAliance
//
//  Created by zues on 17/4/30.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAGetUserInfo.h"
#import "UserModel.h"

@implementation DAGetUserInfo

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetData];
    UserModel *info = [UserModel infoFromDict:dictData];
    
    [_delegate opSuccess:info];
}

@end
