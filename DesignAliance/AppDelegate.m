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


@implementation AppDelegate

+ (AppDelegate *)appDeg{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)showHomePage{
    HomePage *page = [[HomePage alloc] init];
    //下面这行代码会导致，系统默认的tarBar覆盖掉我设置的顶部view，搞了我一天啊
    //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:page];
    self.window.rootViewController = page;
    
    [self.window makeKeyAndVisible];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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


@end
