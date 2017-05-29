//
//  DAModifyPassword.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAModifyPassword.h"

@implementation DAModifyPassword


- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetMessage];
    
    [_delegate opSuccess:dictData]; //告诉代理登录成功
}

@end
