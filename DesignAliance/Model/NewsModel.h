//
//  NewsModel.h
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface NewsModel : DABaseModel

@property(nonatomic, strong) NSString       *cover;
@property(nonatomic, strong) NSString       *link;
@property(nonatomic, strong) NSString       *content;
@property(nonatomic, strong) NSNumber       *time;  //储存13位时间戳数字，不知道有没有影响

@end
