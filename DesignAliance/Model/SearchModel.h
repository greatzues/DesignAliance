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
 {
 "id": 1,
 "name": "江门市团工坊科技有限公司",
 "location": "113.115571,22.630441",
 "manager": "大鹏先生",
 "phone": "13432284345",
 "description": "平面设计 电商设计 画册 VI",
 "latitude": "113.1155710000",
 "longitude": "22.6304410000"
 },
 {
 "id": 2,
 "name": "江门市安维家居设计",
 "location": "113.115863,22.630315",
 "manager": "哈哈",
 "phone": "123",
 "description": "\t水电设计 智能家居",
 "latitude": "113.1158630000",
 "longitude": "22.6303150000"
 },
 {
 "id": 5,
 "name": "雪狼设计（江职分公司）",
 "location": "113.115643,22.630295",
 "manager": "郑先生",
 "phone": "18026759394",
 "description": "3D打印 3D扫描 工业设计 航拍  摩托车设计 家电设计 玩具设计 日用品设计",
 "latitude": "113.1156430000",
 "longitude": "22.6302950000"
 },
 {
 "id": 7,
 "name": "华振装饰设计",
 "location": "113.103786,22.605404",
 "manager": "文先生",
 "phone": "18575006348",
 "description": "室内设计",
 "latitude": "113.1037860000",
 "longitude": "22.6054040000"
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
