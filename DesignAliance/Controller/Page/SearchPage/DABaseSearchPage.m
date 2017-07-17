//
//  DABaseSearchPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseSearchPage.h"

@interface DABaseSearchPage ()

@end

static NSString *const kReuseIdentifier = @"CellReuseIdentifier";

@implementation DABaseSearchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索列表";
    
    self.dataListArry = [NSMutableArray array];
    self.searchListArry = [NSMutableArray array];
    self.dataListArry = [NSMutableArray arrayWithCapacity:100];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化数据
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initTableView{
    self.skTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height)];
    
    self.skTableView.delegate = self;
    self.skTableView.dataSource = self;
    
    //创建UISearchController
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    self.searchController.delegate= self;
    self.searchController.searchResultsUpdater = self;
    
    //提醒字眼
    self.searchController.searchBar.placeholder= @"请输入关键字搜索";

    //搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    
    // 添加 searchbar 到 headerview
    self.skTableView.tableHeaderView = self.searchController.searchBar;
    
    [self.view addSubview: self.skTableView];
    
    self.definesPresentationContext=YES;
}

- (void)opSuccess:(id)data{
    [super opSuccess:data];
    if (self.searchController.active) {
        
        [self.searchListArry addObjectsFromArray:data];
        [self.skTableView reloadData];
    }
    else{
        [self.dataListArry addObjectsFromArray:data];
        [self initTableView];
    }
}

- (void)opFail:(NSString *)errorMessage{
    [super opFail:errorMessage];
    self.searchController.active = NO;
}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchListArry count];
    }
    else{
        return [self.dataListArry count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //点击Item之后透明背景
    return cell;
}


#pragma mark - UISearchControllerDelegate代理

- (void)willPresentSearchController:(UISearchController *)searchController
{
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
}

- (void)presentSearchController:(UISearchController *)searchController
{
}

#pragma 需要复写的方法
- (void)initData{

}

#pragma 点击单元格之后的监听
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma 谓词搜索过滤
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.searchString = [self.searchController.searchBar text];
    if (self.searchListArry!= nil) {
        [self.searchListArry removeAllObjects];
    }
}
@end
