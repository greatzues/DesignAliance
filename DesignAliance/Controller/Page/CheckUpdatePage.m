//
//  CheckUpdatePage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "CheckUpdatePage.h"
#import "DACheckUpdate.h"
#import "CheckUpdateModel.h"
#import <CRToast/CRToast.h>

@implementation CheckUpdatePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getVersionInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)getVersionInfo{
    NSDictionary *opInfo = @{@"url":CheckUpdate,
                             @"body":@"version=1.0"};
    
    _operation = [[DACheckUpdate alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(id)data{
    CheckUpdateModel    *model = [[CheckUpdateModel alloc] init];
    model = data;
    
    _currentVersion.text = model.version;
    _latestVersion.text = model.version;
    _VersionNews.text = model.versionInfo;
}

- (IBAction)getLatestVersion:(id)sender {
    self.ToastTitle = @"当前已经是最新版本";
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    
                                }];
}

@end
