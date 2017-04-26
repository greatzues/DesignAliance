//
//  LoginPage.m
//  DesignAliance
//
//  Created by zues on 17/4/25.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "LoginPage.h"
#import "DALogin.h"
#import "UserModel.h"


@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doLoginEvent:(id)sender{
    
    if(![self checkValidate]){
        return ;
    }
    
    [self showIndicator:LoginCheckTip autoHide:NO afterDelay:NO]; //显示正在登录中
    NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@",username.text,password.text];
    NSDictionary *opInfo = @{@"url":LoginURL,
                             @"body":body};
    
    _operation = [[DALogin alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}


- (void)opSuccess:(UserModel *)data{
    [super opSuccess:data];
}

- (BOOL)checkValidate{
    BOOL validate = YES;
    
    if (username.text.length <= 0 || password.text.length <= 0) {
        validate = NO;
        [self showIndicator:LoginCheckTip autoHide:YES afterDelay:YES];
    }
    
    return validate;
}


@end
