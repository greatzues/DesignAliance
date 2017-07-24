//
//  AboutInfoModel.h
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface AboutInfoModel : DABaseModel

@property(nonatomic, strong) NSString *brief;
@property(nonatomic, strong) NSString *slogan;
@property(nonatomic, strong) NSString *target;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSArray *member;
@property(nonatomic, strong) NSArray *guidance;


@end
