//
//  SearchMissionPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchMissionPage.h"
#import "DAMission.h"
#import "DetailsMissionPage.h"

@interface SearchMissionPage ()

@end

@implementation SearchMissionPage

- (void)initData{
    _pageSize = 10;
    NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
    NSDictionary *opInfo = @{@"url":MissionURL,    //拿到10条新闻资讯
                             @"body":body};
    
    _operation = [[DAMission alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
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
    
    DetailsMissionPage *page = [[DetailsMissionPage alloc] init];
    page.model = self.model;
    [super initToDetails:page];
    
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [super updateSearchResultsForSearchController:searchController];
    
    if (![self.searchString  isEqual: @""]){
        NSString *body = [NSString stringWithFormat:@"mission_title=%@",self.searchString];
        NSDictionary *opInfo = @{@"url":SearchDesignMission,   //按照关键字查找文章
                                 @"body":body};
        
        _operation = [[DAMission alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
        
    }
}

@end
