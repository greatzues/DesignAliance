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
    // Do any additional setup after loading the view.
    [self cycleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cycleScrollView
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 6; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld",(long)i]];
        [images addObject:image];
    }
    
    //self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.cyclePlayView];
    
    CCCycleScrollView *cyclePlayView2 = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/4)];
    cyclePlayView2.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    cyclePlayView2.pageLocation = CCCycleScrollPageViewPositionBottomRight;
    [self.view addSubview:cyclePlayView2];
    
    
    CCCycleScrollView *cyclePlayView3 = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/4)];
    cyclePlayView3.pageLocation = CCCycleScrollPageViewPositionBottomLeft;
    [self.view addSubview:cyclePlayView3];
    
    CCCycleScrollView *cyclePlayView4 = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, self.view.frame.size.height*3/4, self.view.frame.size.width, self.view.frame.size.height/4)];
    cyclePlayView4.pageControl.hidden = YES;
    [self.view addSubview:cyclePlayView4];
    
    
    
    
    
}

- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
}


@end
