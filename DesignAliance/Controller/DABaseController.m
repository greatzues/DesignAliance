//
//  DABaseController.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseController.h"
#import "DAActivityIndicator.h"
#import "LoginPage.h"
#import "AppDelegate.h"
#import <CRToast/CRToast.h>

@implementation DABaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarImage]; //这里是基类，可以把所有导航条都加上
    self.ToastTitle = @"消息发送成功";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //sharedApplication拿到application对象，设置顶部状态栏隐藏状态为NO，也就是显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)dealloc{
    [_operation cancelOp];
    _operation = nil;
}

- (void)opFail:(NSString *)errorMessage{
    BASE_ERROR_FUN(errorMessage);
    //[self showIndicator:errorMessage autoHide:YES afterDelay:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if([errorMessage isEqualToString:LoginAnotherPlace]){
            [[AppDelegate appDeg] showLoginPage];
        }
    }];
    
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
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

- (DAZuesActivity *)showActivityInView:(UIView *)view{
    DAZuesActivity *activity = [[DAActivityIndicator alloc] initWithView:view];
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

- (NSDictionary *)setToast{
    NSDictionary *options = @{
                              kCRToastTextKey : self.ToastTitle,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                              kCRToastFontKey             : [UIFont fontWithName:@"HelveticaNeue-Light" size:16],
                              kCRToastTextColorKey        : [UIColor whiteColor],
                              kCRToastBackgroundColorKey  : [UIColor orangeColor],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    
    return options;
}

@end
