//
//  NoticeModel.h
//  DesignAliance
//
//  Created by zues on 2017/7/1.
//  Copyright © 2017年 zues. All rights reserved.
//  若后面没用上这个类，就可以删掉了

/*
 {
 "code": 20000,
 "message": "获取通知成功",
 "data": {
 "userId": 1,
 "adviceId": 0,
 "missionId": 0,
 "personId": 0
 },
 "dataList": null
 }
 */

#import "DABaseModel.h"

@interface NoticeModel : DABaseModel

@property(strong, nonatomic) NSNumber   *userId;
@property(strong, nonatomic) NSNumber   *adviceId;
@property(strong, nonatomic) NSNumber   *missionId;
@property(strong, nonatomic) NSNumber   *personId;

@end
