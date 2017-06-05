//
//  DesignNewsCell.m
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DesignNewsCell.h"
#import "NewsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DesignNewsCell

- (void)initCell{
    [super initCell];
}

- (void)dealloc
{
    RemoveNofify;
}

- (void)setCellData:(NewsModel *)info
{
    [super setCellData:info];
    
    _descLabel.numberOfLines = 2;
    _descLabel.text = info.content; //到时再显示时间
    
    NSString *imageURL = [NSString stringWithFormat:ImageNews,info.cover];

    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"LittlePictureHolder.png"] options:SDWebImageRetryFailed];
    
}


@end
