//
//  DADesignMissionWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DADesignMissionWidget.h"
#import "MissionModel.h"
#import "AdvertisementModel.h"
#import "DAMission.h"
#import "DAAdvertisement.h"
#import "DesignMissionCell.h"
#import "SDCycleScrollView.h"
#import "DetailsMissionPage.h"
#import "DetailsAdvertisement.h"

static int CycleScrollViewHeight = 156; //定义轮播图高度

@implementation DADesignMissionWidget

- (void)viewDidLoad {
    _getAD = YES;
    self.cellIdentifier = @"DesignMissionCell";
    self.listData = [[NSMutableArray alloc] init];  //初始化设计任务数组
    self.AdlistData = [[NSMutableArray alloc] init]; //初始化轮播图数组
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

#pragma 获取轮播图广告
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
        [self initCycleScrollView];//初始化轮播图
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
    
    if (indexPath.row == 0) {
        tableView.tableHeaderView = self.cycleScrollView;//加载轮播图到tableView的第一条cell
    }
    
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

# pragma 初始化轮播图
- (void)initCycleScrollView
{
    AdvertisementModel *ad;
    NSString  *imageURL;
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < self.AdlistData.count; i++) {
        ad = self.AdlistData[i];
        imageURL = [NSString stringWithFormat:ImageAD,ad.cover];
        [images addObject:imageURL];
    }
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 8, self.view.bounds.size.width, CycleScrollViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"NewsDefault.png"]];
    self.cycleScrollView.imageURLStringsGroup = images;
}

# pragma 轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetailsAdvertisement *page = [[DetailsAdvertisement alloc] init];
    
    page.model = [self.AdlistData objectAtIndex:index];
    [super initToDetails:page];
}

#pragma item点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsMissionPage *page = [[DetailsMissionPage alloc] init];
    
    page.model = [self.listData objectAtIndex:indexPath.row];
    [super initToDetails:page];
}


@end
