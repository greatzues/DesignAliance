//
//  DABaseCell.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseCell.h"



@implementation DABaseCell

- (void)initCell
{
}

- (void)setCellData:(DABaseModel *)info
{
    self.cellInfo = info;
    _titleLabel.text = info.name;
}

- (NSString *)dateToTime:(NSString *)d{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString * timeStampString = d;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue] / 1000];
    
    NSString *myDate = [objDateformat stringFromDate: date];
    return myDate;
}

@end
