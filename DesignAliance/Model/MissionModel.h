//
//  MissionModel.h
//  DesignAliance
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface MissionModel : DABaseModel

@property(nonatomic, strong) NSString       *details;
@property(nonatomic, strong) NSNumber       *count;
@property(nonatomic, strong) NSNumber       *time;  //储存13位时间戳数字，不知道有没有影响
@property(nonatomic, strong) NSString       *cover;
@property(nonatomic, strong) NSString       *issuer;
@property(nonatomic, strong) NSString       *contact;

@end
