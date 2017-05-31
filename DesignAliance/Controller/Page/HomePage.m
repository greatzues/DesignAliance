//
//  HomePage.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "HomePage.h"
#import "PageModel.h"
#import "DALogin.h"
#import "LoginUtility.h"



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
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addTabControllers{
    self.tabBar.tintColor = [UIColor redColor]; //设置顶部选中的字体颜色
    self.viewControllers = [PageModel pageControllers]; //设置底部导航栏
    
}

@end
