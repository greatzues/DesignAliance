//
//  BecomeVipPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "BecomeVipPage.h"
#import <CRToast/CRToast.h>

@implementation BecomeVipPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
    if([userGrade isEqualToString:@"2"]){
        [self.BecomeVipButton setTitle:@"续费" forState:UIControlStateNormal];
    }else{
        [self.BecomeVipButton setTitle:@"联系我们成为VIP" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)contactUs:(id)sender {
    self.ToastTitle = @"正在调用通话功能，稍等片刻...";
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    UIWebView *callWebView = [[UIWebView alloc] init]; NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phoneNumber]];
                                    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
                                    [self.view addSubview:callWebView];
                                }];
}


@end
