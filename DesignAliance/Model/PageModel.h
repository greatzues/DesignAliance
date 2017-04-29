//
//  PageModel.h
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface PageModel : DABaseModel

@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *selectImage;
@property(nonatomic, assign) BOOL      unLoad; //为什么布朗值需要用assign，而不能用strong

+ (NSArray *)pageControllers;

@end
