//
//  DAGetNotice.m
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAGetNotice.h"

@implementation DAGetNotice

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetData]; //直接拿到“data”的数组，回调给opSuccess方法
    
    [_delegate opSuccess:dictData];
}

@end
