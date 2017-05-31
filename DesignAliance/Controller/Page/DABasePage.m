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
    //给所有页面设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DefaultBackground.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)alertView:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip  message:message preferredStyle:UIAlertControllerStyleAlert];
    //UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
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
