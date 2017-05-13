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


@implementation DADesignNewsWidget

- (void)viewDidLoad {
    self.cellIdentifier = @"DesignNewsCell";
    _cellHeight = 80;
    _pageNo = 0;
    _pageSize = 10;
    _hasNextPage = NO;
    self.listData = [[NSMutableArray alloc] init];
    
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

- (BOOL)isReloadLocalData
{
    return [super isReloadLocalData];
}

- (void)requestServerOp
{
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":NewsURL,
                               @"body":body,
                               };
    
    _operation = [[DANews alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)requestNextPageServerOp
{
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":NewsURL,
                               @"body":body
                               };
    
    _operation = [[DANews alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)opSuccess:(NSArray *)data
{
    _hasNextPage = YES;
    _operation = nil;
    
    if (_pageNo == 0) {
        [self.listData removeAllObjects];
    }
    _pageNo++;
    
    [self.listData addObjectsFromArray:data];
    [self updateUI];
    [self hideIndicator];
}

- (void)opFail:(NSString *)errorMessage{
    [super opFail:errorMessage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row < self.listData.count ? _cellHeight:44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hasNextPage?self.listData.count+1:self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    DABaseModel *info = nil;
    
    if (indexPath.row < self.listData.count) {
        cellIdentifier = self.cellIdentifier;
        info = [self.listData objectAtIndex:indexPath.row];
    }
    else {
        cellIdentifier = @"NewsMoreCell";
        [self requestNextPageServerOp];
    }
    
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
    NSLog(@"--------------->>>>>>>>");
    DetailsNewsPage *page = [[DetailsNewsPage alloc] init];
    
    page.newsInfo = [self.listData objectAtIndex:indexPath.row];
    page.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:page animated:YES];
}


@end
