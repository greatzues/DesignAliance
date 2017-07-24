//
//  ModifyPasswordPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "ModifyPasswordPage.h"
#import "DAModifyPassword.h"
#import "LoginPage.h"
#import <CRToast/CRToast.h>

@interface ModifyPasswordPage ()

@end

@implementation ModifyPasswordPage

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)ModifyPasswordAction:(id)sender {
    NSString *oldPAssword = self.oldPassword.text;
    NSString *newPassword = self.nPassword.text;
    NSString *comfirmPassword = self.comfirmPassword.text;
    
    if(![newPassword isEqualToString:comfirmPassword]){
        return ;
    }
    
    
    
    NSString *body = [NSString stringWithFormat:@"oPassword=%@&nPassword=%@",oldPAssword,newPassword];
    NSDictionary *opInfo = @{@"url":ModifyPassword,
                             @"body":body};
    _operation = [[DAModifyPassword alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];

}

- (void)opSuccess:(id)data{
    [super opSuccess:data];
    
    self.ToastTitle = @"密码修改成功，请重新登录";
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    LoginPage *page = [[LoginPage alloc] init];
                                    
                                    page.hidesBottomBarWhenPushed = YES;
                                    self.tabBarController.selectedIndex = 0;
                                    [[self.tabBarController.viewControllers objectAtIndex:0] pushViewController:page animated:YES];
                                }];
}


@end
