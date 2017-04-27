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
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:page];
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LoginPage alloc] init];
    
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
