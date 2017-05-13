//
//  DesignNewsCell.m
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DesignNewsCell.h"
#import "NewsModel.h"
#import "DADownload.h"
#import <SDWebImage/UIImageView+WebCache.h>

//暂时先不用Download图片到本地，后面成功添加了新闻列表再加
@implementation DesignNewsCell

- (void)initCell{
    [super initCell];
    //RegisterNotify(NofifyNewsIcon, @selector(downloadIcon:)); //下载图片暂时先不加上去
}

//- (void)dealloc
//{
//    RemoveNofify;
//}

- (void)setCellData:(NewsModel *)info
{
    [super setCellData:info];
    
    _descLabel.numberOfLines = 2;
    _descLabel.text = info.content; //到时再显示时间
    
    NSString *imageURL = [NSString stringWithFormat:ImageNews,info.cover];

    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"NewsDefault.png"] options:SDWebImageRetryFailed];
    
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
//    _imageView.image = image;
}


@end
