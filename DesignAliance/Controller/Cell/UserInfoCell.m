//
//  UserInfoCell.m
//  DesignAliance
//
//  Created by zues on 2017/6/2.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

+(instancetype)setupCellWith:(UITableView*)tableView AtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=0;
    NSInteger index=0;
    
    switch (indexPath.row) {
        case 0:
            identifier=@"userAvatarCell";
            index=0;
            break;
        case 1:
            identifier=@"userNameCell";
            index=1;
            break;
        case 2:
            identifier=@"userSexCell";
            index=2;
            break;
            
        default:
            break;
            
    }

    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"UserInfoCell" owner:nil options:nil]
              objectAtIndex:index];
    }
    return cell;
}

@end
