//
//  UserModel.h
//  DesignAliance
//
//  Created by zues on 17/4/25.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface UserModel : DABaseModel

@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSString *education;

@end
