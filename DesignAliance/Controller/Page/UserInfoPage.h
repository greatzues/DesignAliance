//
//  UserInfoPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"
#import "UserModel.h"


@interface UserInfoPage : DABaseMyPage

@property (weak, nonatomic) IBOutlet UIImageView *UserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *UserSex;
@property (weak, nonatomic) IBOutlet UILabel *UserEducation;
@property (weak, nonatomic) IBOutlet UILabel *UserSkill;
@property (weak, nonatomic) IBOutlet UILabel *UserDescript;

@property (nonatomic, strong) UserModel      *model;

@end
