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
#import "AppDelegate.h"
#import "LoginUtility.h"
#import "RegisterPage.h"
#import "ForgetPasswordPage.h"

@implementation LoginPage

- (void)viewDidLoad {
    //[self autoLogin];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doLoginEvent:(id)sender{

    if(![self checkValidate]){
        return ;
    }
    
    [LoginUtility saveUserName:username.text PassWord:password.text]; //保存帐号和密码
    
    [self showIndicator:LoginCheckTip autoHide:NO afterDelay:NO]; //显示正在登录中
    NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@",username.text,password.text];
    NSDictionary *opInfo = @{@"url":LoginURL,
                             @"body":body};
    
    _operation = [[DALogin alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}


- (void)opSuccess:(UserModel *)data{
    [super opSuccess:data];
    [[AppDelegate appDeg] showHomePage];
}

- (void)opFail:(NSString *)errorMessage{
    [LoginUtility saveUserName:@"" PassWord:@""];
    [super opFail:errorMessage];
    [self alertView:errorMessage];
}


- (BOOL)checkValidate{
    BOOL validate = YES;
    
    if (username.text.length <= 0 || password.text.length <= 0) {
        validate = NO;
        [self showIndicator:LoginCheckTip autoHide:YES afterDelay:YES];
    }
    
    return validate;
}

//判断是否已经登录过
- (void)autoLogin{
    NSString *U = [LoginUtility readUserName];
    NSString *P = [LoginUtility readPassWord];
    
    
    if([U isEqualToString:@""] && [P isEqualToString:@""]){
        return ;
    }
    
    NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@",U,P];
    NSDictionary *opInfo = @{@"url":LoginURL,
                             @"body":body};
    _operation = [[DALogin alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (IBAction)registerAccount:(id)sender {
    RegisterPage *page = [[RegisterPage alloc] init];
    [self initToDetails:page];
}

- (IBAction)forgetPassword:(id)sender {
    ForgetPasswordPage *page = [[ForgetPasswordPage alloc] init];
    [self initToDetails:page];
}

- (IBAction)txt_DidEndOnExit:(JVFloatLabeledTextField *)sender {
    [sender resignFirstResponder];
}


@end
