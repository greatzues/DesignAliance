//
//  DetailsMissionPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsMissionPage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DAGetCountUp.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface DetailsMissionPage ()

@end

@implementation DetailsMissionPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCount];
    [self setTitle:@"设计任务"];
    [self setNavigationRight:@"share.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMissionPage{
    self.missionTitle.text = self.model.name;
    self.missionTime.text = [self dateToTime: self.model.time.stringValue];
    self.missionCount.text = self.model.count.stringValue;
    self.missionDetails.numberOfLines = 6;
    self.missionDetails.text = self.model.details;
    self.missionIssuer.text = [NSString stringWithFormat:@"发布者：%@",self.model.issuer];
    self.missionContact.text = [NSString stringWithFormat:@"联系方式：%@",self.model.contact];
    
    NSString *imageURL = [NSString stringWithFormat:ImageMission,self.model.cover];
    [self.missionCover sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"LittlePictureHolder.png"] options:SDWebImageRetryFailed];
}

- (void)getCount{
    NSString *body = [NSString stringWithFormat:@"id=%@",self.model.ID];
    NSDictionary *opInfo = @{@"url":GetCountup,
                             @"body":body};
    
    _operation = [[DAGetCountUp alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

-(void)opSuccess:(id)data{
    [super opSuccess:data];
    [self initMissionPage];
    
}

#pragma share news
- (void)doRight:(id)sender{
    [self shareNews];
}

- (void)shareNews{
    NSArray* imageArray = @[[NSString stringWithFormat:ImageMission,self.model.cover]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.model.details
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://zuesblog.xyz/"]//后面记得改回来
                                          title:self.model.name
                                           type:SSDKContentTypeAuto];
        
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state,
                                         SSDKPlatformType platformType,
                                         NSDictionary *userData,
                                         SSDKContentEntity *contentEntity,
                                         NSError *error,
                                         BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               [self alertView:@"分享成功"];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               [self alertView:@"分享失败"];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }
}

@end
