//
//  DAGetCountUp.m
//  DesignAliance
//
//  Created by Apple on 2017/5/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAGetCountUp.h"

@implementation DAGetCountUp

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSDictionary *dictData = [dict objectForKey:NetMessage];
    [_delegate opSuccess:dictData];
}

@end
