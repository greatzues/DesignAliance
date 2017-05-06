//
//  MyPage.h
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"

@interface MyPage : DABasePage<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UILabel        *UserName;
    IBOutlet UIButton       *UserAvatar;
}

@property(strong, nonatomic) NSArray *list;
@property(strong, nonatomic) NSArray *IconList;

@end
