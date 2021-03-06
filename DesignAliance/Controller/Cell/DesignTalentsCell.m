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
    
    _phoneLabel.text = info.phone;
    _skillLabel.text = info.skill;
    
    NSString *imageURL = [NSString stringWithFormat:ImageTalents,info.avatar];
    
    [_imageView was_setCircleImageWithUrlString:imageURL placeholder:[UIImage imageNamed:@"LittlePictureHolder.png"] fillColor:[UIColor whiteColor]];
    
}

@end
