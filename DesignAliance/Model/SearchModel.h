//
//  SearchModel.h
//  DesignAliance
//
//  Created by zues on 17/4/30.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {
 "code": 20000,
 "message": "查询成功",
 "data": null,
 "dataList": [
    {"id":34,
    "name":"创智工业研发有限公司",
    "location":"广东省江门市",
    "manager":"伍生",
    "phone":"18688553318",
    "description":"机电一体化设计 工业产品设计 3D打印",
    "latitude":"22.572781",
    "longitude":"113.13496",
    "businessConfirm":"2",
    "locationConfirm":"1",
    "keyWord":"机电一体化设计 工业产品设计 3D打印 创智"
 }
 ]
 }
 */

#import "DABaseModel.h"

@interface SearchModel : DABaseModel

@property(nonatomic, strong) NSString *manager;
@property(nonatomic, strong) NSString *location;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, strong) NSString *latitude;
@property(nonatomic, strong) NSString *longitude;


//下面是设计顾问与技术顾问的额外model，将公有部分注释掉
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *businessConfirm;
@property(nonatomic, strong) NSString *locationConfirm;
@property(nonatomic, strong) NSString *keyWord;

//@property(nonatomic, strong) NSString *location;
//@property(nonatomic, strong) NSString *phone;
//@property(nonatomic, strong) NSString *desc;
//@property(nonatomic, strong) NSString *latitude;
//@property(nonatomic, strong) NSString *longitude;

@end
