//
//  AppDelegate.h
//  DesignAliance
//
//  Created by zues on 17/4/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DABaseOperation.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LoginPage.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, DAOperationDelegate>

@property (strong, nonatomic) UIWindow  *window;
@property (strong, nonatomic) LoginPage *loginPage;

+ (AppDelegate *)appDeg;
- (void)showHomePage;
@end

