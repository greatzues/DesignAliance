//
//  NewsModel.h
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {
 "code": 20000,
 "message": "查询成功",
 "data": 1,//总数量
 "dataList": [
 {
 "id": 1,
 "title": "标题",
 "cover": "内容",
 "link": "http://mp.weixin.qq.com/s?__biz=MzA4NDk4MjU4Mw==&mid=505054824&idx=2&sn=861185f0c2343aaddc1aee416ff82e3a&chksm=0430c8303347412639e47e98facb7bb78661ec94c8f4e69ce537ff31142fd9c81a8563aad78d#rd",
 "content": "内容",
 "time": 1492517847000
 }
 ]
 }
 */

#import "DABaseModel.h"

@interface NewsModel : DABaseModel

@property(nonatomic, strong) NSString       *cover;
@property(nonatomic, strong) NSString       *link;
@property(nonatomic, strong) NSString       *content;
@property(nonatomic, strong) NSNumber       *time;  //储存13位时间戳数字，不知道有没有影响

@end
