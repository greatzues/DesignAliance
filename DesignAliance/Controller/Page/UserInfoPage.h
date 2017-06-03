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

@property (nonatomic, strong) UserModel      *model;

@property (weak, nonatomic) IBOutlet UITableView *topUserInfoTable;
@property (weak, nonatomic) IBOutlet UITextView *userSkill;
@property (weak, nonatomic) IBOutlet UITextView *userDescription;
@property (weak, nonatomic) IBOutlet UILabel    *userEducation;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;


@property (nonatomic, strong) UIView            *containerView;

@property (nonatomic, strong) NSString          *username;
@property (nonatomic, strong) NSString          *sex;
@property (nonatomic, strong) NSString          *decr;
@property (nonatomic, strong) NSString          *skill;
@property (nonatomic, strong) NSString          *education;
@property (nonatomic, strong) NSString          *educationTemp;

@property (nonatomic, strong) NSArray           *array;

@end
