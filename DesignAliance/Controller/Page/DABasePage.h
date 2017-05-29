//
//  DABasePage.h
//  DesignAliance
//
//  Created by zues on 17/4/26.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseController.h"

@interface DABasePage : DABaseController

@property(nonatomic, strong) DABasePage *page;

- (void)alertView:(NSString *)message;
/*
 跳转到详情页面
 */
- (void)initToDetails:(DABasePage *)page;

@end
