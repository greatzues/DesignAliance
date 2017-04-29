//
//  FxButtonHelper.m
//  FxUI
//
//  Created by Jinbo He on 12-12-25.
//  Copyright (c) 2012年 KingCloud. All rights reserved.
//

#import "DAButtonHelper.h"

@implementation DAButtonHelper

- (void)setButton:(UIButton *)btn
      normalColor:(UIColor *)nColor
    selectedColor:(UIColor *)sColor
{
    [self setSelected:NO];
    
    self.button = btn;
    self.normalColor = nColor;
    self.selectedColor = sColor;
    
    [self setSelected:YES];
}

- (void)setSelected:(BOOL)selected
{
    UIColor *color = selected?_selectedColor:_normalColor;
 
    [_button setTitleColor:color forState:UIControlStateNormal];
    [_button setTitleColor:color forState:UIControlStateHighlighted];
}

@end
