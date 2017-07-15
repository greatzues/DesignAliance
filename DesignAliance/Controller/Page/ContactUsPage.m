//
//  ContactUsPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "ContactUsPage.h"
#import <CRToast/CRToast.h>

@interface ContactUsPage ()

@end

@implementation ContactUsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phoneNumberText setTitle:self.phoneNumber forState:UIControlStateNormal];
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
