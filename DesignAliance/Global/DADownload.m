//
//  DADownload.m
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DADownload.h"
#import "DAFileUtility.h"

@interface DADownload ()
@property(nonatomic, strong) NSOperationQueue       *iconQueue;
@end

@implementation DADownload

+ (DADownload *)download
{
    static DADownload *s_download = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        s_download = [[DADownload alloc] init];
    });
    
    return s_download;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.dictIcons = [[NSMutableDictionary alloc] init];
        
        _iconQueue = [[NSOperationQueue alloc] init];
        [_iconQueue setMaxConcurrentOperationCount:4];
    }
    
    return self;
}


#pragma mark - Download NewsIcon

- (void)cancelDownload
{
    [_iconQueue cancelAllOperations];
}

- (void)setNewsicon:(NewsModel *)newsInfo imageView:(UIImageView *)imageView
{
    NSString *file = [NSString stringWithFormat:NewsIconPrex, newsInfo.ID];
    UIImage *image = nil;
    
    file = [DAGlobal getCacheImage:file];
    
    if ([DAFileUtility isFileExist:file]) {
        image = [UIImage imageWithContentsOfFile:file];
        imageView.image = image;
    }
    else {
        imageView.image = [UIImage imageNamed:@"NewsDefault.png"];
        [self downloadNewsIcon:newsInfo];
    }
}

- (void)downloadNewsIcon:(NewsModel *)info
{
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downNewsIconThread:) object:info];
    
    [_iconQueue addOperation:op];
}
//这里好像没有返回头像给我
- (void)downNewsIconThread:(NewsModel *)info
{
    NSString *file = [NSString stringWithFormat:NewsIconPrex, info.ID];
    NSString *imageURL = [NSString stringWithFormat:ImageNews,info.cover]; //拼接图片请求url
    NSURL *url = [NSURL URLWithString:imageURL]; //拿到封面图片的url
    
    file = [DAGlobal getCacheImage:file];
    if (url != nil) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSDictionary *dictInfo = @{
                                   @"info": info,
                                   @"data": image
                                   };
        SEL sel = @selector(notifyNewsIconDownload:);
        
        [data writeToFile:file atomically:YES];
        [self performSelectorOnMainThread:sel
                               withObject:dictInfo
                            waitUntilDone:NO];
    }
}

- (void)notifyNewsIconDownload:(NSDictionary *)dict
{
    SendNotify(NofifyNewsIcon, dict)
}

@end
