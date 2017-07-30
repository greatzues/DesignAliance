//
//  DesignTalentsCell.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DesignTalentsCell.h"
#import "TalentsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+extension.h"

@implementation DesignTalentsCell

- (void)initCell{
    [super initCell];
}

- (void)dealloc
{
    RemoveNofify;
}

- (void)setCellData:(TalentsModel *)info
{
    [super setCellData:info];
    //如果不是企业用户就把第二张图标替换成“专业技能”图标，如果是，就把第二张图标换成“电话”图标
        NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
        if([userGrade isEqualToString:@"2"]){
            _phoneLabel.text = info.phone;
            _twoImageView.image = [UIImage imageNamed:@"talentPhone.png"];
            _threeImageView.image = [UIImage imageNamed:@"talentSkill.png"];
            _skillLabel.numberOfLines = 2;
            _skillLabel.text = info.skill;
        }else{
            _phoneLabel.numberOfLines = 2;
            _phoneLabel.text = info.skill;
            _twoImageView.image = [UIImage imageNamed:@"talentSkill.png"];
            
            _skillLabel.text = @"";
        }
    
    NSString *imageURL = [NSString stringWithFormat:ImageTalents,info.avatar];
    [_imageView was_setCircleImageWithUrlString:imageURL placeholder:[UIImage imageNamed:@"LittlePictureHolder.png"] fillColor:[UIColor whiteColor]];
    
}

@end
