//
//  DABaseDetailsPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"

@interface DABaseDetailsPage : DABasePage

/*
 *  时间戳转化为日期
 *  @param d 传入13位字符串
 */
- (NSString *)dateToTime:(NSString *)d;

@end
