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


//暂时先不用Download图片到本地，后面成功添加了新闻列表再加
@implementation DesignNewsCell

- (void)initCell{
    [super initCell];
    RegisterNotify(NofifyNewsIcon, @selector(downloadIcon:)); //下载图片暂时先不加上去
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
    
    [[DADownload download] setNewsicon:info imageView:_imageView];
}

- (void)downloadIcon:(NSNotification *)notification
{
//    NSDictionary *dict = [notification object];
//    NewsModel *info = [dict objectForKey:@"info"];
//    
//    if ([info.ID isEqualToString:self.cellInfo.ID]) {
//        UIImage *image = [dict objectForKey:@"data"];
//        _imageView.image = image;
//    }
    NSDictionary *dict = [notification object];
    UIImage *image = [dict objectForKey:@"cover"];
    _imageView.image = image;
}
@end
