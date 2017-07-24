//
//  AdviserModel.h
//  DesignAliance
//
//  Created by zues on 2017/6/15.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface AdviserModel : DABaseModel

@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *location;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, strong) NSString *latitude;
@property(nonatomic, strong) NSString *longitude;
@property(nonatomic, strong) NSString *businessConfirm;
@property(nonatomic, strong) NSString *locationConfirm;
@property(nonatomic, strong) NSString *keyWord;

@end
