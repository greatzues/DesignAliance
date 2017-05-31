//
//  DABaseWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseController.h"

@interface DABaseWidget : DABaseController

@property(strong, nonatomic) NSMutableArray     *listData;

- (void)updateUI;
- (void)reloadData;
- (BOOL)isReloadLocalData;

@end
