//
//  DAAdvertisement.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAAdvertisement.h"
#import "AdvertisementModel.h"

@implementation DAAdvertisement

- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    NSArray *infos = [AdvertisementModel arrayFromDict:dict];
    [_delegate opSuccess:infos];
}


@end
