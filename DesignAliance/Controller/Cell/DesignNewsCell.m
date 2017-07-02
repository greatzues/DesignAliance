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
    
    
    _descLabel.text = [self dateToTime: info.time.stringValue];
    
    NSString *imageURL = [NSString stringWithFormat:ImageNews,info.cover];

    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"LittlePictureHolder.png"] options:SDWebImageRetryFailed];

}


@end
