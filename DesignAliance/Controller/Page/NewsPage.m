//
//  NewsPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "NewsPage.h"
#import "SearchNewsPage.h"
#import "SearchMissionPage.h"
#import "SearchTalentsPage.h"
#import "BecomeVipPage.h"
#import "DAGetNotice.h"

@implementation NewsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    SearchNewsPage  *NewsPage = [[SearchNewsPage alloc] init];
    self.page = NewsPage;
    
    [self setNavigationRight:@"NavigationSquare.png"];
    [self setNavigationTitleImage:@"logo.png"];
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
    self.cbs_titleColor = [UIColor colorWithRed:54.0f/255.0f green:54.0f/255.0f blue:54.0f/255.0f alpha:1.0];
    self.cbs_titleSelectedColor = [UIColor colorWithRed:32.0f/255.0f green:160.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    self.cbs_bottomLineColor = [UIColor colorWithRed:32.0f/255.0f green:160.0f/255.0f blue:255.0f/255.0f alpha:1.0];
    
    //先设置cbs_titleArray和cbs_viewArray再调用initSegment
    [self initSegment];
}
//设置顶部三个tab点中事件的响应
- (void)didSelectSegmentIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            {
                SearchNewsPage  *NewsPage = [[SearchNewsPage alloc] init];
                self.page = NewsPage;
            }
            break;
        case 1:
            {
                SearchMissionPage *MissionPage = [[SearchMissionPage alloc] init];
                self.page = MissionPage;
            }
            break;
        case 2:
        {
            SearchTalentsPage *TalentsPage = [[SearchTalentsPage alloc] init];
            self.page = TalentsPage;
            
        }
            break;
        default:
            break;
    }
    
}

-(void)doRight:(id)sender{
    self.page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.page animated:YES];
}

@end
