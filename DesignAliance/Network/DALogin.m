//
//  DALogin.m
//  DesignAliance
//
//  Created by zues on 17/4/25.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DALogin.h"
#import "UserModel.h"

@implementation DALogin

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetData];
    UserModel *info = [UserModel infoFromDict:dictData];
    
    NSString *userMessage = [dict objectForKey:@"message"];
    
    
    [_delegate opSuccess:info]; //告诉代理登录成功
}

@end
