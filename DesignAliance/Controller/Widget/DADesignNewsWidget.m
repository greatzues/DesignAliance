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

@implementation DADesignNewsWidget

- (void)viewDidLoad {
    self.cellIdentifier = @"DesignNewsCell";
    _cellHeight = 80;
    _pageNo = 1;
    _pageSize = 10;
    self.listData = [[NSMutableArray alloc] init];
    
    //初始化下拉刷新头部
    _header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //初始化下拉刷新尾部
    _footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    _tableView.mj_header = _header;
    _tableView.mj_footer = _footer;
    [_tableView.mj_header beginRefreshing];
    
    [super viewDidLoad];
}

- (void)reloadData
{
    // 停止网络请求
    [_operation cancelOp];
    _operation = nil;
    _pageNo = 0;
    _pageSize = 10;
    
    // 先清除上次内容
    [self.listData removeAllObjects];
    [super reloadData];
}


- (void)loadNewData
{
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
    ++_pageNo;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":NewsURL,
                               @"body":body
                               };
    
    _operation = [[DANews alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)opSuccess:(NSArray *)data
{
    _operation = nil;
    
    if (_pageNo == 1) {
        [self.listData removeAllObjects];
    }
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [self.listData addObjectsFromArray:data];
    [self updateUI];
}

- (void)opFail:(NSString *)errorMessage{
    [super opFail:errorMessage];
    [_footer setTitle:errorMessage forState:MJRefreshStateIdle];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    DABaseModel *info = nil;
    
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
    page.hidesBottomBarWhenPushed = YES; //隐藏底部tab
    
    [self.navigationController pushViewController:page animated:YES];
}


@end
