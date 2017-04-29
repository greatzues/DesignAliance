//
//  FxButtonHelper.h
//  FxUI
//
//  Created by Jinbo He on 12-12-25.
//  Copyright (c) 2012年 KingCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAButtonHelper : NSObject

@property(nonatomic, strong) UIButton   *button;
@property(nonatomic, strong) UIColor    *normalColor;
@property(nonatomic, strong) UIColor    *selectedColor;

- (void)setButton:(UIButton *)btn
      normalColor:(UIColor *)nColor
    selectedColor:(UIColor *)sColor;

- (void)setSelected:(BOOL)selected;

@end
