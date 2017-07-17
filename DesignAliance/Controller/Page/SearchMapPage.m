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
    MAMapPoint  point2;
    CLLocationDistance distance;
}

@end

@implementation SearchMapPage

-(void)viewDidLoad{
    _pointArray = [NSMutableArray array];
    _distanceArray = [NSMutableArray array];
    initSearchUrl = SearchCompanyDefault;
    
    [super viewDidLoad];
    _selectTitleBody = @"key_word";
    _selectTitleUrl = SearchCompanyByKey;
}

- (void)initTableView{
    [super initTableView];
    
    self.searchController.searchBar.placeholder= @"搜索共享设备、设计团队";
    
    NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
    if([userGrade isEqualToString:@"2"]){
        self.searchController.searchBar.scopeButtonTitles = @[@"共享设备、团队",@"设计顾问",@"技术顾问"];
        self.searchController.searchBar.delegate = self;
    }
}

- (void)initData{
    _pageSize = 30;
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:flag];
    }
    
    if (self.searchController.active) {
        //这里判断是由于在点击搜索框拿到焦点时，self.searchController.active为true，但此时self.searchListArry没有数据，会出现数组越界错误
        if([self.searchListArry count] != 0){
            self.model = [self.searchListArry objectAtIndex:indexPath.row];
        }else{
            self.model = [self.dataListArry objectAtIndex:indexPath.row];
        }
    }
    else{
        self.model = [self.dataListArry objectAtIndex:indexPath.row];
    }
    
    
    [cell.textLabel setText:self.model.name];
    [cell.detailTextLabel setText:[self.distanceArray objectAtIndex:indexPath.row]];
    cell.imageView.image=[UIImage imageNamed:@"mapNormal.png"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (self.searchController.active) {
        //这里判断是由于在点击搜索框拿到焦点时，self.searchController.active为true，但此时self.searchListArry没有数据，会出现数组越界错误
        if([self.searchListArry count] != 0){
            self.model = [self.searchListArry objectAtIndex:indexPath.row];
        }else{
            self.model = [self.dataListArry objectAtIndex:indexPath.row];
        }
    }
    else{
        self.model = [self.dataListArry objectAtIndex:indexPath.row];
    }
    
    @try {
        //初始化pop回去的地图组件
        self.mapPage =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        //先将原来的标注和数组清空，就可以只存储搜索的结果了
        [self.mapPage.mapView removeAnnotations:self.mapPage.pointArray];
        [self.mapPage.pointArray removeAllObjects];
        
        //遍历每一次搜索的结果，而不是全部结果
        for(SearchModel * s in _pointArray){
            MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
            point.coordinate = CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue);
            point.title = s.name;
            
            //下面三行添加补习社距离，同时注释掉point.subtitle = s.desc
            point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue));
            distance = MAMetersBetweenMapPoints(self.point1,point2);
            int dis = distance/1000;
            
            point.subtitle = [NSString stringWithFormat:@"距离您%d km",dis];
            
            [self.mapPage.companyInfo setObject:s forKey:point.title];
            [self.mapPage.pointArray addObject:point];
        }
    } @catch (NSException *exception) {
        NSLog(@"----------->>>>>>>11111%@", exception);
    }
    
    @try {
        //返回时中心点标注为刚刚点中的那个
        self.mapPage.pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.model.latitude.doubleValue, self.model.longitude.doubleValue);
        self.mapPage.pointAnnotation.title = self.model.name;
        //self.mapPage.pointAnnotation.subtitle = self.model.desc;
        
        point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.model.latitude.doubleValue, self.model.longitude.doubleValue));
        distance = MAMetersBetweenMapPoints(self.point1,point2);
        int dis = distance/1000;
        
        self.mapPage.pointAnnotation.subtitle = [NSString stringWithFormat:@"距离您%d km",dis];
        
        //全部添加到Annotations中，方便再次搜索一次清空
        [self.mapPage.pointArray addObject:self.mapPage.pointAnnotation];
        [self.mapPage.mapView addAnnotations:self.mapPage.pointArray];
        [self.mapPage.mapView selectAnnotation:self.mapPage.pointAnnotation animated:YES];
        
        [self.navigationController popToViewController:self.mapPage animated:YES];
    } @catch (NSException *exception) {
        NSLog(@"----------->>>>>>>22222%@", exception);
    }
    
    

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
            
            self.searchController.searchBar.placeholder= @"搜索共享设备、设计团队";
            break;
        case 1:
            _selectTitleBody = @"type=d&key_word";
            _selectTitleUrl = SearchAdviser;
            
            initSearchUrl = ShowAllAdviser;
            self.searchController.searchBar.placeholder= [NSString stringWithFormat:@"搜索%@",searchBar.scopeButtonTitles[selectedScope]];
            break;
        case 2:
            _selectTitleBody = @"type=t&key_word";
            _selectTitleUrl = SearchAdviser;
            
            initSearchUrl = ShowAllAdviser;
            self.searchController.searchBar.placeholder= [NSString stringWithFormat:@"搜索%@",searchBar.scopeButtonTitles[selectedScope]];
            break;
            
        default:
            break;
    }
    [self initData];
}

//重写父类访问成果之后的操作
- (void)opSuccess:(id)data{
    [self.searchListArry removeAllObjects];
    
    //用setArray，不然会重复添加标注
    [_pointArray setArray:data];
    
    for(SearchModel * s in data){
        point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(s.latitude.doubleValue, s.longitude.doubleValue));
        distance = MAMetersBetweenMapPoints(self.point1,point2);
        int d = distance/1000;
        
        NSString *dis = [NSString stringWithFormat:@"距离您%d km",d];
        
        [self.distanceArray addObject:dis];
    }
    
    [super opSuccess:data];
    
}

#pragma 在打开搜索界面时获得输入焦点
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self performSelector:@selector(setCorrectFocus) withObject:NULL afterDelay:0.8];
}

-(void) setCorrectFocus {
    [self.searchController.searchBar becomeFirstResponder];
}

#pragma 拦截默认返回pop操作，重写返回的方法
- (BOOL)navigationShouldPopOnBackButton{
    self.mapPage =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    self.mapPage.pointArray = self.pointArray;
    [self.navigationController popToViewController:self.mapPage animated:true];
    
    return YES;
}

@end
