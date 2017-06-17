//
//  MyPage.h
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"
#import "UserModel.h"

@interface MyPage : DABasePage<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UILabel        *UserName;
    IBOutlet UIButton       *UserAvatar;
    __weak IBOutlet UILabel *UserSkill;
}

@property(strong, nonatomic) NSMutableArray *list;
@property(strong, nonatomic) NSArray        *IconList;
@property(strong, nonatomic) NSString       *userGrade;

@property (nonatomic, strong) UserModel      *model;

- (void)initData;

@end
