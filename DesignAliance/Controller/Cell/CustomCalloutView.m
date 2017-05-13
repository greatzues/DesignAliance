//
//  CustomCalloutView.m
//  DesignAliance
//
//  Created by zues on 17/5/10.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "CustomCalloutView.h"
#import "MapPage.h"

@interface CustomCalloutView()

@property (nonatomic,strong) UIImageView * thumbnailImageView;  //!< 缩略图
@property (nonatomic,strong) UILabel * titleLabel;  //!< 标题Label
@property (nonatomic,strong) UILabel * addressLabel;  //!< 地址Label

@end

@implementation CustomCalloutView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        //其他控件的初始化写在这里
        self.backgroundColor = [UIColor clearColor];
        
        //初始化缩略图,距离边距为5，宽度为70，高度为50
        //self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 50)];
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(178, 8, 15, 15)];
        self.thumbnailImageView.backgroundColor =  [UIColor whiteColor];
        [self addSubview:self.thumbnailImageView];
        
        //初始化标题Label,如果添加缩略图，则用注释的代码代替下一行的代码
        //self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+70+5, 5, 120-8, 20)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 175, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor =  [UIColor whiteColor];
        self.titleLabel.text = @"title";
        [self addSubview:self.titleLabel];
        
        //初始化地址Label，如果添加缩略图，则用注释的代码代替下一行的代码
        //self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(5+70+5, 20, 120-8, 20*2)];
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 190-8, 20*2)];
        self.addressLabel.font = [UIFont systemFontOfSize:12];
        self.addressLabel.numberOfLines = 0;
        self.addressLabel.textColor =  [UIColor lightGrayColor];
        self.addressLabel.text = @"address";
        [self addSubview:self.addressLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setAddress:(NSString *)address
{
    self.addressLabel.text = address;
}

- (void)setThumbnail:(UIImage *)thumbnail
{
    self.thumbnailImageView.image = thumbnail;
}


- (void)drawRect:(CGRect)rect{
    
    //绘制曲线
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, 2.0f);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    
    CGRect calloutRect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat triangleHeight = 10;   //倒三角的高度
    
    CGFloat x = CGRectGetMinX(calloutRect);
    CGFloat midX = CGRectGetMidX(calloutRect);
    CGFloat width = CGRectGetMaxX(calloutRect);
    
    CGFloat y = CGRectGetMinY(calloutRect);
    CGFloat height = CGRectGetMaxY(calloutRect)-10;
    
    //用起始点开始
    CGContextMoveToPoint(contextRef, x+radius, y);
    
    //画上面的直线
    CGContextAddLineToPoint(contextRef, x+width-radius, y);
    //画右上角圆弧
    CGContextAddArcToPoint(contextRef, x+width, y, x+width, y+radius, radius);
    
    //画右边的直线
    CGContextAddLineToPoint(contextRef, x+width, y+height-radius);
    //画右下角弧线
    CGContextAddArcToPoint(contextRef, x+width, y+height, x+width-radius, y+height, radius);
    
    //画倒三角靠右的下边的直线
    CGContextAddLineToPoint(contextRef, midX+triangleHeight, y+height);
    
    //画倒三角
    CGContextAddLineToPoint(contextRef, midX, y+height+triangleHeight);
    CGContextAddLineToPoint(contextRef, midX-triangleHeight, y+height);
    //画倒三角靠左的下边的直线
    CGContextAddLineToPoint(contextRef, x+radius, y+height);
    
    //画左下角的弧线
    CGContextAddArcToPoint(contextRef, x, y+height, x, y+height-radius, radius);
    
    //画左边的直线
    CGContextAddLineToPoint(contextRef, x, y+radius);
    //画左上角的弧线
    CGContextAddArcToPoint(contextRef, x, y, x+radius, y, radius);
    
    CGContextClosePath(contextRef);
    
    CGContextFillPath(contextRef);
    
    //添加阴影
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    //阴影的透明度
    self.layer.shadowOpacity = 1.0f;
    //阴影的偏移
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

@end
