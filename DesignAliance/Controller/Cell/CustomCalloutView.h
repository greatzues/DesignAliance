//
//  CustomCalloutView.h
//  DesignAliance
//
//  Created by zues on 17/5/10.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView

@property (nonatomic,strong) UIImage * thumbnail;  //!< 缩略图片
@property (nonatomic,copy) NSString * title;  //!< 标题
@property (nonatomic,copy) NSString * address; //!< 地址

@end
