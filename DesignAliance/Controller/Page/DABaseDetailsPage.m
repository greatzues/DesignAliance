//
//  DABaseDetailsPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseDetailsPage.h"

@interface DABaseDetailsPage ()

@end

@implementation DABaseDetailsPage

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)dateToTime:(NSString *)d{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString * timeStampString = d;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue] / 1000];
    
    NSString *myDate = [objDateformat stringFromDate: date];
    return myDate;
}

#pragma 重写设置顶部logo的方法，将顶部的logo删掉
- (void)setNavigationTitleImage:(NSString *)imageName{
    
}
@end
