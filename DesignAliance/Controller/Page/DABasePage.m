//
//  DABasePage.m
//  DesignAliance
//
//  Created by zues on 17/4/26.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"

@implementation DABasePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitleImage:@"logo.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)alertView:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)initToDetails:(DABasePage *)page{
    _page = page;
    _page.hidesBottomBarWhenPushed = YES; //隐藏底部tab
    [self.navigationController pushViewController:_page animated:YES];
}

@end
