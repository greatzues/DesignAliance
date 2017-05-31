//
//  CustomAnnotationView.m
//  DesignAliance
//
//  Created by zues on 17/5/10.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    if (self.selected == selected) {
        return;
    }
    if (selected == YES) {
        //如果气泡为空则初始化气泡
        if (self.calloutView == nil) {
            
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, 250, 70)];
            
            //设置气泡的中心点,正的偏移使view朝右下方移动，负的朝左上方，单位是屏幕坐标
            CGFloat center_x = self.bounds.size.width/2;
            CGFloat center_y = -self.bounds.size.height-10; //设置气泡中心点位于屏幕中心的正上方10像素位置
            self.calloutView.center = CGPointMake(center_x, center_y);
        }
        
        //给calloutView赋值
        self.calloutView.title = self.annotation.title;
        self.calloutView.address = self.annotation.subtitle;
    
        
        [self addSubview:self.calloutView];
        
    } else {
        //移除气泡
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
        UIView *view = [super hitTest:point withEvent:event];
    
        if (view == nil) {
    
            CGPoint tempoint = [self.calloutView.button convertPoint:point fromView:self];
    
            if (CGRectContainsPoint(self.calloutView.button.bounds, tempoint))
    
            {
                view = self.calloutView.button;
            }
    
        }
        
        return view;
    
}

@end
