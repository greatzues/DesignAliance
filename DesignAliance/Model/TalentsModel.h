//
//  TalentsModel.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {
 "code": 20000,
 "message": "查询成功",
 "data": 1,
 "dataList": [
 {"id":2,
 "name":"zero",
 "sex":"m",
 "phone":"13692190630",
 "avatar":"4d638e20716ec2088a00034c.jpg",
 "skill":"php",
 "education":"本科",
 "description":"前端工程师，熟悉javascript，html，css"
 }
 ]
 }
 */

#import "DABaseModel.h"

@interface TalentsModel : DABaseModel

@property(nonatomic, strong) NSString *sex;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *skill;
@property(nonatomic, strong) NSString *education;
@property(nonatomic, strong) NSString *desc;


@end
