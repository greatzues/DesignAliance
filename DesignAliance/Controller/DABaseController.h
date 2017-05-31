//
//  DABaseController.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DABaseOperation.h"
#import "DAActivity.h"

//设置顶部导航栏的动作和图片
@interface DABaseController : UIViewController <DAOperationDelegate> {
    DABaseOperation     *_operation;
    DAActivity          *_activity;
}

- (void)showIndicator:(NSString *)tipMessage
             autoHide:(BOOL)hide
           afterDelay:(BOOL)delay;
- (void)hideIndicator;

- (void)setNavigationTitleImage:(NSString *)imageName;
- (void)setNavigationLeft:(NSString *)imageName sel:(SEL)sel;
- (void)setNavigationRight:(NSString *)imageName;
- (void)setStatusBarStyle:(UIStatusBarStyle)style;
- (void)setNavBarImage;
- (IBAction)doBack:(id)sender;
- (IBAction)doRight:(id)sender;

@end
