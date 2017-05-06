//
//  MyDetailsPage.m
//  DesignAliance
//
//  Created by zues on 17/5/4.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MyDetailsPage.h"
#import "DAGetUserInfo.h"
#import "UserModel.h"

@implementation MyDetailsPage
- (void)viewDidLoad{
    
}

- (void)initData{
    NSDictionary *opInfo = @{@"url":GetUserInfo,
                             @"body":@""};
    
    _operation = [[DAGetUserInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(id)data{
    [super opSuccess:data];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //实现cell复用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    
    //设置cell标题和图片
    
    return cell;
}

@end
