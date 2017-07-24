//
//  NoticeModel.h
//  DesignAliance
//
//  Created by zues on 2017/7/1.
//  Copyright © 2017年 zues. All rights reserved.
//  若后面没用上这个类，就可以删掉了

#import "DABaseModel.h"

@interface NoticeModel : DABaseModel

@property(strong, nonatomic) NSNumber   *userId;
@property(strong, nonatomic) NSNumber   *adviceId;
@property(strong, nonatomic) NSNumber   *missionId;
@property(strong, nonatomic) NSNumber   *personId;

@end
