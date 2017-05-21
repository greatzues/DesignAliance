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
 {
 "id": 1,
 "name": "Clanner",
 "sex": "m",
 "phone": "13692190638",
 "avatar": "暂无",
 "skill": "安卓开发，java程序员",
 "companyId": 1
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
@property(nonatomic, strong) NSString *companyId;


@end
