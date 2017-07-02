//
//  HomePage.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "HomePage.h"
#import "PageModel.h"//
#import "WZLBadgeImport.h"
#import "DABaseOperation.h"
#import "DAGetNotice.h"
#import "DAModifyPassword.h"
#import "AppDelegate.h"
#import "NoticeModel.h"


@implementation HomePage

- (id)init{
    self  = [super init];
    if (self){
        [self addTabControllers];
    }
    
    return self;
}

- (void)viewDidLoad {
    self.title = LoginTitle;
    
    [self getNotice];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addTabControllers{
    //self.tabBar.tintColor = [UIColor redColor]; //设置顶部选中的字体颜色
    self.viewControllers = [PageModel pageControllers]; //设置底部导航栏
}

#pragma UITabBarDelegate代理
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if([item.title isEqualToString:@"资讯"]){
        [secondItem clearBadge];
    }
}


- (void)getNotice{
    _operation = [[DABaseOperation alloc] init];
    
    NSDictionary *opInfo = @{@"url":GetNotice,
                             @"body":@""};
    
    _operation = [[DAGetNotice alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(id)data{
    if([data isKindOfClass:[NSString class]]){
        return;
    }
    
    adviceId = [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"adviceId"]];
    missionId = [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"missionId"]];
    personId = [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"personId"]];
    if([[data objectForKey:@"adviceId"] isEqualToNumber:adviceId] && [[data objectForKey:@"missionId"] isEqualToNumber:missionId]) {
        return ;
    }
    
    secondItem = self.tabBar.items[1];
    [secondItem showBadgeWithStyle:WBadgeStyleNew value:0 animationType:WBadgeAnimTypeBounce];
    
    [self modifyNotice];
}

- (void)opFail:(NSString *)errorMessage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if([errorMessage isEqualToString:LoginAnotherPlace]){
            [[AppDelegate appDeg] showLoginPage];
        }
    }];
    
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)modifyNotice{
    NSString *body = [NSString stringWithFormat:@"advice_id=%@&mission_id=%@&person_id=%@",adviceId,missionId,personId];
    NSDictionary *opInfo = @{@"url":ModifyNotice,
                             @"body":body};
    
    _operation = [[DAModifyPassword alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

@end
