//
//  SearchModel.h
//  DesignAliance
//
//  Created by zues on 17/4/30.
//  Copyright © 2017年 zues. All rights reserved.
//

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
