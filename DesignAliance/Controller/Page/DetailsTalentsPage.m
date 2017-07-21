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
#import <CRToast/CRToast.h>

@implementation DetailsTalentsPage

- (void)viewDidLoad {    
    [super viewDidLoad];
    [self initPage];
    [self setTitle:@"设计人才"];
    //[self setNavigationRight:@"share.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPage{
    self.name.text = self.model.name;
    if([self.model.sex isEqualToString:@"m"]){
        self.sex.text = @"男";
    }else{
        self.sex.text = @"女";
    }
    [self.contact setTitle:self.model.phone forState:UIControlStateNormal];
    
    self.skill.text = self.model.skill;
    self.desr.text = self.model.desc;
    self.education.text = self.model.education;
    
    
    NSString *imageURL = [NSString stringWithFormat:ImageTalents,self.model.avatar];

    
    [self.avatar was_setCircleImageWithUrlString:imageURL placeholder:[UIImage imageNamed:@"LittlePictureHolder.png"] fillColor:[UIColor whiteColor]];
}

//#pragma share news
//- (void)doRight:(id)sender{
//    [self shareNews];
//}
//
//- (void)shareNews{
//    NSArray* imageArray = @[[NSString stringWithFormat:ImageTalents,self.model.avatar]];
//    
//    if (imageArray) {
//        
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:self.model.skill
//                                         images:imageArray
//                                            url:[NSURL URLWithString:@"http://zuesblog.xyz/"] //后面记得修改
//                                          title:self.model.name
//                                           type:SSDKContentTypeAuto];
//        
//        [ShareSDK showShareActionSheet:nil
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state,
//                                         SSDKPlatformType platformType,
//                                         NSDictionary *userData,
//                                         SSDKContentEntity *contentEntity,
//                                         NSError *error,
//                                         BOOL end) {
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                           {
//                               [self alertView:@"分享成功"];
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               [self alertView:@"分享失败"];
//                               break;
//                           }
//                           default:
//                               break;
//                       }
//                   }];
//    }
//}

- (IBAction)contactUs:(id)sender {
    
    
    self.ToastTitle = @"正在调用通话功能，稍等片刻...";
    
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    UIWebView *callWebView = [[UIWebView alloc] init]; NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.model.phone]];
                                    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
                                    [self.view addSubview:callWebView];
                                }];
}

@end
