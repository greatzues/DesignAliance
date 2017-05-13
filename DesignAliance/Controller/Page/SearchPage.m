//
//  SearchPage.m
//  DesignAliance
//
//  Created by zues on 17/5/1.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchPage.h"
#import "SearchModel.h"
#import "DASearchInfo.h"
#import "MapPage.h"

@interface SearchPage ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>

//searchController
@property (nonatomic,retain) UISearchController *searchController;

//tableView
@property (nonatomic,strong) UITableView *skTableView;

//数据源
@property (nonatomic,strong) NSMutableArray *dataListArry;
@property (nonatomic,strong) NSMutableArray *searchListArry;

@end

static NSString *const kReuseIdentifier = @"CellReuseIdentifier";


@implementation SearchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索列表";
    
    self.dataListArry = [NSMutableArray array];
    self.searchListArry = [NSMutableArray array];
    self.dataListArry = [NSMutableArray arrayWithCapacity:100];
    
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
    //隐藏tableViewCell下划线
    //    self.skTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //创建UISearchController
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    self.searchController.delegate= self;
    self.searchController.searchResultsUpdater = self;
    
    //包着搜索框外层的颜色
    //self.searchController.searchBar.barTintColor = [UIColor yellowColor];
    
    //提醒字眼
    self.searchController.searchBar.placeholder= @"请输入关键字搜索";
    
    //提前在搜索框内加入搜索词
    //self.searchController.searchBar.text = @"设计";
    
    //搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);

    
    // 添加 searchbar 到 headerview
    self.skTableView.tableHeaderView = self.searchController.searchBar;
    
    [self.view addSubview: self.skTableView];
    
    //self.searchController.searchBar.scopeButtonTitles=@[@"设备",@"软件",@"其他"];
    self.definesPresentationContext=YES;
}

- (void)initData{
    _pageSize = 10;
    NSString *body = [NSString stringWithFormat:@"pageSize=%ld",_pageSize];
    NSDictionary *opInfo = @{@"url":SearchCompanyDefault,
                             @"body":body};
    
    _operation = [[DASearchInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
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

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        SearchModel *a = [self.searchListArry objectAtIndex:indexPath.row];
       [cell.textLabel setText:a.name];
    }
    else{
        SearchModel *s = [self.dataListArry objectAtIndex:indexPath.row];
        [cell.textLabel setText:s.name];
    }
    return cell;
}

//点击单元格之后的监听
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        SearchModel *a = [self.searchListArry objectAtIndex:indexPath.row];
        MapPage *map =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        map.search = a;
        [self.navigationController popToViewController:map animated:YES];
    }
    else{
        SearchModel *s = [self.dataListArry objectAtIndex:indexPath.row];
        MapPage *map =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        map.search = s;
        [self.navigationController popToViewController:map animated:YES];
    }

}


//谓词搜索过滤
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [self.searchController.searchBar text];
    //NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchListArry!= nil) {
        [self.searchListArry removeAllObjects];
    }
    
    if (![searchString  isEqual: @""]){
        NSString *body = [NSString stringWithFormat:@"key=%@",searchString];
        NSDictionary *opInfo = @{@"url":SearchCompanyByKey,
                                 @"body":body};
    
        _operation = [[DASearchInfo alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
        
    }
}



#pragma mark - UISearchControllerDelegate代理
//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    //[self.view addSubview:self.searchController.searchBar];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}
@end
