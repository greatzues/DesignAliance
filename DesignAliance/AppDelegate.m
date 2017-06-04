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

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@implementation AppDelegate

+ (AppDelegate *)appDeg{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)showHomePage{
    HomePage *page = [[HomePage alloc] init];
    self.window.rootViewController = page;
    [self.window makeKeyAndVisible];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AMapServices sharedServices].apiKey = AMapKey;
    [Bmob registerWithAppKey:BombKey];
    
    [self initShareSDK];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //下面三行代码可以将LoginPage的的顶部tab显示出来，看上去会比较美观
    LoginPage *page = [[LoginPage alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:page];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible]; //展示界面，并且让它成为主要界面
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

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

@end
