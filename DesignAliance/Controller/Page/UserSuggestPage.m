//
//  UserSuggestPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "UserSuggestPage.h"
#import "DAModifyPassword.h" //同样都是接收message字段

@implementation UserSuggestPage

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)UserSuggestButton:(id)sender {
    NSString *mail = self.UserMail.text;
    NSString *content = self.SuggestContent.text;
    
    NSString *body = [NSString stringWithFormat:@"content=%@&mail=%@",content,mail];
    NSDictionary *opInfo = @{@"url":GetUserSuggest,
                             @"body":body};
    _operation = [[DAModifyPassword alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

-(void)opSuccess:(id)data{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
