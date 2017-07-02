//
//  DADesignNewsWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DADesignNewsWidget.h"
#import "DANews.h"
#import "DABaseCell.h"
#import "DetailsNewsPage.h"
#import "MJRefresh.h"

#import "AdvertisementModel.h"
#import "DAAdvertisement.h"
#import "DetailsAdvertisement.h"
#import "SDCycleScrollView.h"

static int CycleScrollViewHeight = 156; //定义轮播图高度

@implementation DADesignNewsWidget

- (void)viewDidLoad {
    
    self.cellIdentifier = @"DesignNewsCell";
    self.listData = [[NSMutableArray alloc] init];
    
    _getAD = YES;
    self.AdlistData = [[NSMutableArray alloc] init]; //初始化轮播图数组
    [self getAdlistData];
    
    [super viewDidLoad];
    
    _cellHeight= 100;
}

- (void)loadNewData
{
    _getAD = NO;
    _pageNo = 1;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":NewsURL,
                               @"body":body,
                               };
    
    _operation = [[DANews alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)loadMoreData
{
    _getAD = NO;
    ++_pageNo;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":NewsURL,
                               @"body":body
                               };
    
    _operation = [[DANews alloc] initWithDelegate:self opInfo:dictInfo];
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
    
    //保存第一条资讯ID
    NewsModel *model = [self.listData objectAtIndex:0];
    NSInteger advice = [model.ID integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger:advice forKey:@"adviceId"];

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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsNewsPage *page = [[DetailsNewsPage alloc] init];
    
    page.newsInfo = [self.listData objectAtIndex:indexPath.row];
    [super initToDetails:page];
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
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 8, self.view.bounds.size.width, CycleScrollViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"BigPictureHolder.png"]];
    self.cycleScrollView.imageURLStringsGroup = images;
}

# pragma 轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetailsAdvertisement *page = [[DetailsAdvertisement alloc] init];
    
    page.model = [self.AdlistData objectAtIndex:index];
    [super initToDetails:page];
}

@end
