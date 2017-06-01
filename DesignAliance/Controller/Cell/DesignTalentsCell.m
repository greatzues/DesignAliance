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
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"NewsDefault.png"] options:SDWebImageRetryFailed];
    
    [_imageView was_setCircleImageWithUrl:[NSURL URLWithString:imageURL] placeholder:[UIImage imageNamed:@"NewsDefault.png"] fillColor:[UIColor whiteColor]];
    
}

@end
