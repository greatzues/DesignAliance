//
//  DAActivity.h
//  DesignAliance
//
//  Created by zues on 17/4/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAZuesActivity : UIView
//使用copy关键字是防止在String在被NSMutableString赋值的时候，进行深度拷贝，可以在NSMutableString被修改之后，NSString的值不变
@property (copy) NSString *labeltext;
@property (copy) NSString *detailsLabelText;


//封装activity的出栈和退栈
- (id)initWithView:(UIView *)view;
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
