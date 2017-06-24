//
//  ContactUsPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "ContactUsPage.h"

@interface ContactUsPage ()

@end

@implementation ContactUsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneNumberText.text = self.phoneNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)contactUs:(id)sender {
    
    UIWebView *callWebView = [[UIWebView alloc] init]; NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phoneNumber]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
}



@end
