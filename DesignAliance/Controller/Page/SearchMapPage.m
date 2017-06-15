//
//  SearchPage.m
//  DesignAliance
//
//  Created by zues on 17/5/1.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchMapPage.h"
#import "SearchModel.h"
#import "DASearchInfo.h"
#import "MapPage.h"
#import "UIViewController+BackButtonHandler.h" //导入拦截默认返回事件的类

@interface SearchMapPage ()<UISearchResultsUpdating,UISearchBarDelegate>

@end

@implementation SearchMapPage

- (void)initTableView{
    
    [super initTableView];
    
    self.searchController.searchBar.scopeButtonTitles = @[@"设计公司",@"设计顾问",@"技术顾问"];
    self.searchController.searchBar.delegate = self;
    //self.searchController.searchBar.showsScopeBar = YES; // 这行代码导致搜索bar状态栏重叠
}

- (void)initData{
    _selectTitleBody = [NSString stringWithFormat:@"key_word=%@",self.searchString];
    _selectTitleUrl = SearchCompanyByKey;
    
    _pageSize = 15;
    NSString *body = [NSString stringWithFormat:@"pageSize=%ld",(long)_pageSize];
    NSDictionary *opInfo = @{@"url":SearchCompanyDefault,
                             @"body":body};
    
    _operation = [[DASearchInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        self.model = [self.searchListArry objectAtIndex:indexPath.row];
    }
    else{
        self.model = [self.dataListArry objectAtIndex:indexPath.row];
    }
    [cell.textLabel setText:self.model.name];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        self.model = [self.searchListArry objectAtIndex:indexPath.row];
    }
    else{
        self.model = [self.dataListArry objectAtIndex:indexPath.row];
    }
    
    self.mapPage =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    self.mapPage.search = self.model;
    
    //在返回之后将焦点聚在对应点击的补习社，本来是放到前面的页面操作的，但是由于第一次打开地图返回会出现地图失去焦点，显示空白
    CLLocationCoordinate2D coor;
    coor.latitude = self.model.latitude.doubleValue;
    coor.longitude =self.model.longitude.doubleValue;
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    point.coordinate = coor;
    point.title = self.model.name;
    point.subtitle = self.model.desc;
    self.mapPage.mapView.centerCoordinate = coor;
    
    [self.navigationController popToViewController:self.mapPage animated:YES];

}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [super updateSearchResultsForSearchController:searchController];
    
//    _selectTitleBody = [NSString stringWithFormat:@"key_word=%@",self.searchString];
//    _selectTitleUrl = SearchCompanyByKey;
    
    if (![self.searchString  isEqual: @""]){
        NSString *body = [NSString stringWithFormat:@"key_word=%@",self.searchString];
        NSDictionary *opInfo = @{@"url":_selectTitleUrl,
                                 @"body":_selectTitleBody};
    
        _operation = [[DASearchInfo alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
        
    }
}

#pragma mark - UISearchBarDelegate 点击按钮后，进行搜索页更新
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    switch (selectedScope) {
        case 0:
            _selectTitleBody = [NSString stringWithFormat:@"key_word=%@",self.searchString];
            _selectTitleUrl = SearchCompanyByKey;
            break;
        case 1:
            _selectTitleBody = [NSString stringWithFormat:@"key_word=%@&type=d",self.searchString];
            _selectTitleUrl = SearchAdviser;
            break;
        case 2:
            _selectTitleBody = [NSString stringWithFormat:@"key_word=%@&type=t",self.searchString];
            _selectTitleUrl = SearchAdviser;
            break;
            
        default:
            break;
    }
}

//重写父类访问成果之后的操作
- (void)opSuccess:(id)data{
    [super opSuccess:data];
    [self.pointArray addObjectsFromArray:data];
}

- (BOOL)navigationShouldPopOnBackButton{
    self.mapPage =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    self.mapPage.pointArray = self.pointArray;
    //返回时触发定位方法
    //[self.mapPage locationClick];
    [self.navigationController popToViewController:self.mapPage animated:true];
    
    return NO;
}

@end
