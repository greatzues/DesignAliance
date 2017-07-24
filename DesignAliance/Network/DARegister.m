//
//  DARegister.m
//  DesignAliance
//
//  Created by zues on 17/5/9.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DARegister.h"

@implementation DARegister

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetMessage];
    
    [_delegate opSuccess:dictData];
}

@end
