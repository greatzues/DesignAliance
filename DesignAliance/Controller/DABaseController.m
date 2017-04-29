//
//  DABaseController.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseController.h"
#import "DAActivityIndicator.h"


@implementation DABaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarImage]; //这里是基类，可以把所有导航条都加上
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self setNavBarImage];
    
    //sharedApplication拿到application对象，设置顶部状态栏隐藏状态为NO，也就是显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //友盟统计，暂时没接入进去
    //StatisIntoPage(GetPageName());
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //StatisOutPage(GetPageName()); //友盟统计
}

- (void)dealloc{
    [_operation cancelOp];
    _operation = nil;
}

- (void)opFail:(NSString *)errorMessage{
    BASE_ERROR_FUN(errorMessage);
    [self showIndicator:errorMessage autoHide:YES afterDelay:YES];
}

- (void)opSuccess:(id)data{
    [self hideIndicator];
}

- (void)setNavigationTitleImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationItem.titleView = imageView;
}

- (void)setNavBarImage{
    UIImage *image = [UIImage imageNamed:[DAGlobal isSystemLowIOS7]?@"NavigationBar44.png":@"NavigationBar64.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:18]
                                };
    
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}

- (UIButton *)customButton:(NSString *)imageName
                  selector:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)setNavigationLeft:(NSString *)imageName
                      sel:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self customButton:imageName selector:sel]];
    
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setNavigationRight:(NSString *)imageName{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[self customButton:imageName selector:@selector(doRight:)]];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)style{
    [[UIApplication sharedApplication] setStatusBarStyle:style];
}

- (IBAction)doRight:(id)sender{

}

- (IBAction)doBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Activity methods

- (DAActivity *)showActivityInView:(UIView *)view{
    DAActivity *activity = [[DAActivityIndicator alloc] initWithView:view];
    CGRect frame = view.bounds; //边界矩形，在坐标系中描述试图的位置和大小
    
    activity.frame = frame;
    [view addSubview:activity];
    activity.labeltext = @"";
    
    return activity;
}

- (void)showIndicator:(NSString *)tipMessage
             autoHide:(BOOL)hide
           afterDelay:(BOOL)delay{
    if (_activity == nil) {
        _activity.labeltext = tipMessage;
        [_activity show:NO];
    }
    
    if (hide && _activity.alpha >= 1.0) {
        if (delay)
            [_activity hide:YES afterDelay:AnimationSecond];
        else
            [_activity hide:YES];
    }
}

- (void)hideIndicator{
    [_activity hide:YES];
}

@end
