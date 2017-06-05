//
//  DetailsTalentsWidget.m
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsTalentsPage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+extension.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@implementation DetailsTalentsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
    [self setTitle:@"设计人才"];
    [self setNavigationRight:@"NavigationSquare.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPage{
    self.name.text = self.model.name;
    self.sex.text = self.model.sex; //后面再转化时间戳
    self.contact.text = self.model.phone;
    self.desc.numberOfLines = 5;
    self.desc.text = self.model.desc;
    self.skill.text = self.model.skill;
    self.education.text = self.model.education;
    
    NSString *imageURL = [NSString stringWithFormat:ImageTalents,self.model.avatar];
//    [self.avatar sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"NewsDefault.png"] options:SDWebImageRetryFailed];
    
    [self.avatar was_setCircleImageWithUrlString:imageURL placeholder:[UIImage imageNamed:@"LittlePictureHolder.png"] fillColor:[UIColor whiteColor]];
}

#pragma share news
- (void)doRight:(id)sender{
    [self shareNews];
}

- (void)shareNews{
    NSArray* imageArray = @[[NSString stringWithFormat:ImageTalents,self.model.avatar]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:self.model.skill
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://zuesblog.xyz/"] //后面记得修改
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
