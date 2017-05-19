//
//  DADesignMissionWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DADesignMissionWidget.h"
#import "CCCycleScrollView.h"

@interface DADesignMissionWidget() <CCCycleScrollViewClickActionDeleage>
@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;
@end

@implementation DADesignMissionWidget

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cycleScrollView];//初始化轮播图
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)cycleScrollView
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 6; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld",(long)i]];
        [images addObject:image];
    }
    
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.cyclePlayView];
}
//监听轮播图点击事件
- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
}


@end
