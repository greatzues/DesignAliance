//
//  MyPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MyPage.h"
#import "DAGetUserInfo.h"
#import "UserModel.h"

@implementation MyPage
@synthesize list = _list;
@synthesize IconList = _IconList;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.list = nil;
    self.IconList = nil;
}

- (void)initData{
    self.list = MyPageArray;
    self.IconList = MyPageIconArray;
    
    NSDictionary *opInfo = @{@"url":GetUserInfo,
                             @"body":@""};
    
    _operation = [[DAGetUserInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(UserModel *)data{
    [super opSuccess:data];
    [UserName setText:data.name];
    NSString *imageURL = [NSString stringWithFormat:ImageAvatar,data.avatar];
    //这样加载图片超慢，需要修改一下加载的方式
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    UserAvatar.image = [UIImage imageWithData:imageData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    
    //设置cell标题和图片
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    UIImage *image = [UIImage imageNamed:[self.IconList objectAtIndex:row]];
    cell.imageView.image = image;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self alertView:[self.list objectAtIndex:[indexPath row]]];
}

@end
