//
//  DADesignMissionWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DADesignMissionWidget.h"
#import "CCCycleScrollView.h"
#import "MissionModel.h"
#import "DAMission.h"
#import "DesignMissionCell.h"
#import "DetailsNewsPage.h"
#import "MJRefresh.h"
#import "AdvertisementModel.h"
#import "DAAdvertisement.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DADesignMissionWidget

- (void)viewDidLoad {
    _getAD = YES;
    self.cellIdentifier = @"DesignMissionCell";
    self.listData = [[NSMutableArray alloc] init];
    [self getAdlistData];
    [super viewDidLoad];
}   

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadNewData
{
    _getAD = NO;
    _pageNo = 1;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":MissionURL,
                               @"body":body,
                               };
    
    _operation = [[DAMission alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)loadMoreData
{
    _getAD = NO;
    ++_pageNo;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":MissionURL,
                               @"body":body
                               };
    
    _operation = [[DAMission alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}
//获取轮播图广告
- (void)getAdlistData{
    NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
    NSDictionary *dictInfo = @{@"url":Advertisement,
                               @"body":body
                               };
    
    _operation = [[DAAdvertisement alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)opSuccess:(NSArray *)data
{
    _operation = nil;
    
    if(_getAD){
        [self.AdlistData addObjectsFromArray:data];
        [self cycleScrollView];//初始化轮播图
        return ;
    }
    
    
    if (_pageNo == 1) {
        [self.listData removeAllObjects];
    }
    [self.listData addObjectsFromArray:data];
    [super opSuccess:data];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    DABaseModel *info = nil;
    
    tableView.tableHeaderView = self.cyclePlayView;//加载轮播图到tableView的第一条cell
    
    cellIdentifier = self.cellIdentifier;
    info = [self.listData objectAtIndex:indexPath.row];
    
    DABaseCell *cell = (DABaseCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    
    [cell setCellData:info];
    
    return cell;
}

//这个是item点击之后的监听
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsNewsPage *page = [[DetailsNewsPage alloc] init];
    
    page.newsInfo = [self.listData objectAtIndex:indexPath.row];
    [super initToDetails:page];
}

# pragma 初始化轮播图
- (void)cycleScrollView
{
    
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld",(long)i]];
        [images addObject:image];
    }
    
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
}

# pragma 轮播图点击事件
- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
}


@end
