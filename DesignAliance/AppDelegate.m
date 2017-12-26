//
//  AppDelegate.m
//  DesignAliance
//
//  Created by zues on 17/4/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginPage.h"
#import "HomePage.h"
#import <BmobSDK/Bmob.h>
#import "LoginUtility.h"
#import "DABaseOperation.h"
#import "DALogin.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@implementation AppDelegate

+ (AppDelegate *)appDeg{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self autoLogin];
    [AMapServices sharedServices].apiKey = AMapKey;
    [Bmob registerWithAppKey:BombKey];
    
    [self initShareSDK];

    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
    
}


- (void)autoLogin{
    DABaseOperation *operation;
    
    self.loginPage = [[LoginPage alloc] initWithNibName:@"LoginPage" bundle:nil];
    self.homePage = [[HomePage alloc] init];
    
    NSString *U = [LoginUtility readUserName];
    NSString *P = [LoginUtility readPassWord];
    
    
    if([U isEqualToString:@""] && [P isEqualToString:@""]){
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.loginPage];
        self.window.rootViewController = navController;
        
        return [self.window makeKeyAndVisible];
    }
    
    NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@",U,P];
    NSDictionary *opInfo = @{@"url":LoginURL,
                             @"body":body};
    operation = [[DALogin alloc] initWithDelegate:self opInfo:opInfo];
    [operation executeOp];
}

- (void)opSuccess:(id)data{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
    self.window.rootViewController = self.homePage;
    [self.window makeKeyAndVisible];
}

- (void)opFail:(NSString *)errorMessage{
    
    [LoginUtility quitLogin];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self showLoginPage];
        
    }];
    
    [alert addAction:okAction];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma initial ShareSDK
- (void)initShareSDK{
    [ShareSDK registerApp:@"1e44ead1fb198"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
     onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1404108835"
                                           appSecret:@"608e5e37446f555407a6e6059f99f1aa"
                                         redirectUri:@"http://119.29.14.160/Design/manager/login.html"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxebead29b1b247310"
                                       appSecret:@"dfde1d51630348b4dba617c5f88ba11f"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106088615"
                                      appKey:@"BiAvL1GKfWy6nkNG"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

- (void)showHomePage{
    self.window.rootViewController = self.homePage;
    [self.window makeKeyAndVisible];
    
}

- (void)showLoginPage{
    self.window.rootViewController = self.loginPage;
    [self.window makeKeyAndVisible];
}

@end
