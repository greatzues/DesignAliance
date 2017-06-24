//
//  AboutInfoModel.h
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {
 "code": 20000,
 "message": "获取数据成功",
 "data": {
 "brief": "简介",
 "slogan": "口号",
 "target": "目标",
 "member": [
 "团队成员1",
 "团队成员2",
 "团队成员3"
 ],
 "guidance": [
 "指导单位1",
 "指导单位2",
 "指导单位3"
 ],
 "phone": "联系方式"
 },
 "dataList": null
 }
 */

#import "DABaseModel.h"

@interface AboutInfoModel : DABaseModel

@property(nonatomic, strong) NSString *brief;
@property(nonatomic, strong) NSString *slogan;
@property(nonatomic, strong) NSString *target;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSArray *member;
@property(nonatomic, strong) NSArray *guidance;


@end
