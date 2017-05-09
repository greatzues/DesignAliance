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
//#import <BmobMessageSDK/BmobSMS.h>


@implementation RegisterPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Floating Label Demo", @"");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    JVFloatLabeledTextField *titleField = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(50, 200, [UIScreen mainScreen].bounds.size.width-100, 30)];
//    //textField类型
//    titleField.borderStyle = UITextBorderStyleRoundedRect;
//    titleField.font = [UIFont systemFontOfSize:16];
//    //placeholder 的属性设置
//    titleField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:NSLocalizedString(@"Title", @"")attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
//    //弹上去的字体大小、颜色
//    titleField.floatingLabelFont = [UIFont boldSystemFontOfSize:10];
//    titleField.floatingLabelTextColor = [UIColor brownColor];
//    //是否有清除按钮
//    titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self.view addSubview:titleField];
//    //这个属性是约束Autosizing控制，当打开约束的时候，要约束条件完全，否则可能试图丢失。
//    //    titleField.translatesAutoresizingMaskIntoConstraints = NO;
//    titleField.keepBaseline = YES;
//    //    [titleField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//开启倒计时效果
- (IBAction)openCountdown:(id)sender{
    if([phoneNumber.text isEqualToString:@""]){
        return ;
    }
    
    [getVericationCode startWithTime:60 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f] countColor:[UIColor grayColor]];
    
    //请求验证码
//    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:phoneNumber.text andTemplate:@"test" resultBlock:^(int msgId, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        } else {
//            //获得smsID
//            NSLog(@"sms ID：%d",msgId);
//        }
//    }];
}


@end
