//
//  DADownload.h
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

@interface DADownload : NSObject

@property(nonatomic, strong)NSMutableDictionary     *dictIcons;

+ (DADownload *)download;

- (void)cancelDownload;
- (void)setNewsicon:(NewsModel *)newsInfo imageView:(UIImageView *)imageView;

@end
