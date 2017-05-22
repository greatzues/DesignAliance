//
//  SearchTalentsPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchTalentsPage.h"
#import "DATalents.h"

@implementation SearchTalentsPage

- (void)initData{
    _pageSize = 10;
    NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
    NSDictionary *opInfo = @{@"url":TalentsURl,    //拿到10条新闻资讯
                             @"body":body};
    
    _operation = [[DATalents alloc] initWithDelegate:self opInfo:opInfo];
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
    
    self.page =  [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    self.page.search = self.model;
    [self.navigationController popToViewController:self.page animated:YES];
    
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [super updateSearchResultsForSearchController:searchController];
    
    if (![self.searchString  isEqual: @""]){
        NSString *body = [NSString stringWithFormat:@"skill=%@",self.searchString];
        NSDictionary *opInfo = @{@"url":SearchDesignTalents,   //按照关键字查找文章
                                 @"body":body};
        
        _operation = [[DATalents alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
        
    }
}

@end