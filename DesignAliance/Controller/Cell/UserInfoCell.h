//
//  UserInfoCell.h
//  DesignAliance
//
//  Created by zues on 2017/6/2.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseCell.h"

@interface UserInfoCell : DABaseCell

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *userSex;


+(instancetype)setupCellWith:(UITableView*)tableView AtIndexPath:(NSIndexPath *)indexPath;

@end
