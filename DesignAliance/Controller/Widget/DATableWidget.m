//
//  DATableWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DATableWidget.h"
#import "DABaseCell.h"
#import "DABasePage.h"


@implementation DATableWidget

-(void)viewDidLoad{
    _cellHeight = 80;
    _pageNo = 1;
    _pageSize = 10;
    
    //初始化DABasepage
    _page = [[DABasePage alloc] init];
    //初始化下拉刷新头部
    self.header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //初始化下拉刷新尾部
    self.footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    _tableView.mj_header = self.header;
    _tableView.mj_footer = self.footer;
    [_tableView.mj_header beginRefreshing];
}

- (void)updateUI{
    [_tableView reloadData];
}

#pragma mark - Refresh methods
- (void)loadNewData{
    
};

- (void)loadMoreData{
    
};

#pragma mark - DAOperationDelegate methods

- (void)opSuccess:(id)data{
    [super opSuccess:data];
    
    //self.listData = data;
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [self updateUI];
}

- (void)opFail:(NSString *)errorMessage{
    if([errorMessage isEqualToString:LoginAnotherPlace]){
        [super opFail:errorMessage];
    }

    [self.footer setTitle:errorMessage forState:MJRefreshStateIdle];
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource methods

-(void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DABaseCell *cell = (DABaseCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:self.cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    //这行代码触发cell的设置列表数据函数，只要继承DABaseWidget，都可以将返回的dataList整条传入
    [cell setCellData:[self.listData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)initToDetails:(DABasePage *)page{
    _page = page;
    _page.hidesBottomBarWhenPushed = YES; //隐藏底部tab
    
    [self.navigationController pushViewController:_page animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}


@end
