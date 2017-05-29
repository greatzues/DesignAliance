//
//  UserInfoPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "UserInfoPage.h"

@interface UserInfoPage ()

@end

@implementation UserInfoPage

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData{
    self.UserName.text = self.model.name;
    self.UserSex.text = self.model.sex;
    self.UserEducation.text = self.model.name;
    self.UserName.text = self.model.name;
    self.UserName.text = self.model.name;
    self.UserName.text = self.model.name;
}

@end
