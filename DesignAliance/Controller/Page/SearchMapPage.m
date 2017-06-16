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

@interface SearchMapPage ()<UISearchResultsUpdating,UISearchBarDelegate>{
    NSString    *initSearchUrl;
}

@end

@implementation SearchMapPage

-(void)viewDidLoad{
    _pointArray = [NSMutableArray array];
    initSearchUrl = SearchCompanyDefault;
    
    [super viewDidLoad];
    _selectTitleBody = @"key_word";
    _selectTitleUrl = SearchCompanyByKey;
    
}

- (void)initTableView{
    [super initTableView];
    
    self.searchController.searchBar.scopeButtonTitles = @[@"设计公司",@"设计顾问",@"技术顾问"];
    self.searchController.searchBar.delegate = self;
}

- (void)initData{
    _pageSize = 15;
    NSString *body = [NSString stringWithFormat:@"pageSize=%ld&pageNo=1",(long)_pageSize];
    NSDictionary *opInfo = @{@"url":initSearchUrl,
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
    
    //初始化pop回去的地图组件
    self.mapPage =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    //[self.mapPage.mapView removeAnnotations:self.mapPage.pointArray]; 本来是想移除所有的标注，然后再加上去的，先把今天的代码推上去再说
    
    //遍历搜索的结果，如果在下面的opSuccss中设置为数组setObject的话，那么这里返回的就是每一次搜索的结果，而不是全部结果
    for(SearchModel * s in _pointArray){
        MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue);
        point.title = s.name;
        point.subtitle = s.desc;
        
        [self.mapPage.companyInfo setObject:s forKey:point.title];
        [self.mapPage.pointArray addObject:point];
    }
    [self.mapPage.mapView addAnnotations:self.mapPage.pointArray];
    
    //返回时中心点标注为刚刚点中的那个
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    self.mapPage.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.model.latitude.doubleValue, self.model.longitude.doubleValue);
    point.title = self.model.name;
    point.subtitle = self.model.desc;
    
    
    [self.navigationController popToViewController:self.mapPage animated:YES];

}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [super updateSearchResultsForSearchController:searchController];
    
    if (![self.searchString  isEqual: @""]){
        NSString *body = [NSString stringWithFormat:@"%@=%@",_selectTitleBody,self.searchString];
        NSDictionary *opInfo = @{@"url":_selectTitleUrl,
                                 @"body":body};
    
        _operation = [[DASearchInfo alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
        
    }
}

#pragma mark - UISearchBarDelegate 点击按钮后，进行搜索页更新
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
    switch (selectedScope) {
        case 0:
            _selectTitleBody = @"key_word";
            _selectTitleUrl = SearchCompanyByKey;
            
            initSearchUrl = SearchCompanyDefault;
            
            break;
        case 1:
            _selectTitleBody = @"type=d&key_word";
            _selectTitleUrl = SearchAdviser;
            
            initSearchUrl = ShowAllAdviser;
            
            break;
        case 2:
            _selectTitleBody = @"type=t&key_word";
            _selectTitleUrl = SearchAdviser;
            
            initSearchUrl = ShowAllAdviser;
            
            break;
            
        default:
            break;
    }
    [self initData];
}

//重写父类访问成果之后的操作
- (void)opSuccess:(id)data{
    [self.searchListArry removeAllObjects];
    
    //或许这里用setArray会更好一点，不然就会重复添加标注
    [_pointArray addObjectsFromArray:data];
    //[_pointArray setArray:data];
    [super opSuccess:data];
    
}

- (BOOL)navigationShouldPopOnBackButton{
    self.mapPage =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    self.mapPage.pointArray = self.pointArray;
    [self.navigationController popToViewController:self.mapPage animated:true];
    
    return YES;
}

@end
