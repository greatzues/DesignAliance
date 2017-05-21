//
//  MissionModel.h
//  DesignAliance
//
//  Created by Apple on 2017/5/20.
//  Copyright © 2017年 zues. All rights reserved.
//


/*
 {
 "code": 20000,
 "message": "查询成功",
 "data": 1,
 "dataList": [
 {"id":1,
 "title":"App UI设计",
 "details":"设计一个app的界面。包括每个页面的布局和各个图标。",
 "count":25,
 "time":1493899749000,
 "cover":"4e0717729e499105430010e7.jpg",
 "issuer":"Clanner",
 "contact":"13692190638"
 }
 ]
 }
 */

#import "DABaseModel.h"

@interface MissionModel : DABaseModel

@property(nonatomic, strong) NSString       *details;
@property(nonatomic, strong) NSNumber       *count;
@property(nonatomic, strong) NSNumber       *time;  //储存13位时间戳数字，不知道有没有影响
@property(nonatomic, strong) NSString       *cover;
@property(nonatomic, strong) NSString       *issuer;
@property(nonatomic, strong) NSString       *contact;

@end
