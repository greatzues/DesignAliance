//
//  AdviserModel.h
//  DesignAliance
//
//  Created by zues on 2017/6/15.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {
 "code": 20000,
 "message": "获取数据成功",
 "data": null,
 "dataList": [
 {
 "id": 1,
 "type": "2",
 "name": "Clanner",
 "location": "深圳",
 "phone": "13692190638",
 "description": "描述",
 "latitude": "纬度",
 "longitude": "经度",
 "businessConfirm": "1",
 "locationConfirm": "1",
 "keyWord": "关键字"
 }
 ]
 }
 */

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
