//
//  NewsPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "NewsPage.h"


@implementation NewsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationLeft:@"NavigationBell.png" sel:nil];
    [self setNavigationRight:@"NavigationSquare.png"];
    [self setNavigationTitleImage:@"NavBarIcon.png"]; //设置顶部标题的背景图片

    [self initColumnBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initColumnBar{
    self.view.backgroundColor = [UIColor whiteColor];
    //设置各个标签名字
    self.cbs_titleArray = TitleArray;
    //设置各个标签对应的ViewController，如果数量不对会崩溃
    self.cbs_viewArray = ViewArray;
    
    self.cbs_Type = CBSSegmentHeaderTypeScroll;
    self.cbs_headerColor = [UIColor whiteColor];
    self.cbs_titleSelectedColor = [UIColor blackColor];
    self.cbs_bottomLineColor = [UIColor blackColor];
    self.cbs_buttonHeight = 40;
    
    //先设置cbs_titleArray和cbs_viewArray再调用initSegment
    [self initSegment];
}

- (void)didSelectSegmentIndex:(NSInteger)index
{
    NSLog(@"-->>%ld", (long)index);
}

@end
