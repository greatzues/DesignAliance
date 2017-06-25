//
//  DetailsNewsPage.m
//  DesignAliance
//
//  Created by zues on 17/5/12.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsNewsPage.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface DetailsNewsPage ()<UIWebViewDelegate>

@end

@implementation DetailsNewsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:self.newsInfo.name];
    [self initWebView];
    //[self setNavigationRight:@"share.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initWebView{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -NavBarHeight)];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.newsInfo.link]
                             
                                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                             
                                              timeoutInterval:15];
    webView.delegate=self;//委托
    [webView loadRequest:request];
    [self.view addSubview: webView];
    
}

#pragma webView代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -NavBarHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setAlpha:0.6];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:view.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];

}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
        
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:@"网络不给力，连接超时请稍后重试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[self navigationController] popViewControllerAnimated:YES];
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma share news
//- (void)doRight:(id)sender{
//    [self shareNews];
//}

//- (void)shareNews{
//    NSArray* imageArray = @[[NSString stringWithFormat:ImageNews,self.newsInfo.cover]];
//    
//    if (imageArray) {
//        
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:self.newsInfo.content
//                                         images:imageArray
//                                            url:[NSURL URLWithString:self.newsInfo.link]
//                                          title:self.newsInfo.name
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

@end
