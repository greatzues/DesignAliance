//
//  RegisterPage.m
//  DesignAliance
//
//  Created by zues on 17/5/6.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "RegisterPage.h"
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
#import "UIButton+countDown.h"
#import "DARegister.h"
#import <BmobSDK/BmobSMS.h>


@implementation RegisterPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"注册", @"");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//开启倒计时效果
- (IBAction)openCountdown:(id)sender{
    if([phoneNumber.text isEqualToString:@""]||phoneNumber.text.length!=11){
        [self alertView:@"错误的手机号码"];
        return ;
    }
    
    [getVericationCode startWithTime:60 title:VericationCodeTitle countDownTitle:@"s" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
    
    //请求验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumber.text andTemplate:VericationTemplate resultBlock:^(int msgId, NSError *error) {
        if (error) {
            NSLog(@"------------》》》》%@",error);
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",msgId);
            
            [BmobSMS querySMSCodeStateInBackgroundWithSMSId:msgId resultBlock:^(NSDictionary *dic, NSError *error) {
                if (dic) {
                    NSLog(@"%@",dic);
                    if([[dic objectForKey:@"sms_state"] isEqualToString:@"SUCCESS"]){
                        NSLog(@"%@",[dic objectForKey:@"sms_state"]);
                    }
                } else {
                    NSLog(@"%@",error);
                }
            }];
        }
    }];
}
//验证短信验证码
- (IBAction)registerAccount:(id)sender {
    if(![passwordNumber.text isEqualToString:confirmNumber.text]){
        [self alertView:@"确认密码不一致，请重新输入"];
        return ;
    }
    
    
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:phoneNumber.text andSMSCode:VerificationCode.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"%@",@"验证成功，可执行用户请求的操作");
        } else {
            NSLog(@"%@",error);
            return [self alertView:@"短信验证失败，请重新输入验证码"];
        }
    }];
    
    NSString *body = [NSString stringWithFormat:@"phone=%@&password=%@",phoneNumber.text,passwordNumber.text];
    NSDictionary *opInfo = @{@"url":Register,
                             @"body":body};
    _operation = [[DARegister alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(id)data{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)opFail:(NSString *)errorMessage{
    [super opFail:@"注册失败，请检查网络后重试"];
}

- (IBAction)backToLoginPage:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)txt_DidEndOnExit:(JVFloatLabeledTextField *)sender {
    [sender resignFirstResponder];
}

@end
