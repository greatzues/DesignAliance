//
//  SearchNewsPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchNewsPage.h"
#import "DANews.h"
#import "DetailsNewsPage.h"

@implementation SearchNewsPage

- (void)initData{
    _pageSize = 10;
    NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
    NSDictionary *opInfo = @{@"url":NewsURL,    //拿到10条新闻资讯
                             @"body":body};
    
    _operation = [[DANews alloc] initWithDelegate:self opInfo:opInfo];
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
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (self.searchController.active) {
        self.model = [self.searchListArry objectAtIndex:indexPath.row];
    }
    else{
        self.model = [self.dataListArry objectAtIndex:indexPath.row];
    }
        
    DetailsNewsPage *page = [[DetailsNewsPage alloc] init];
    page.newsInfo = self.model;
    [super initToDetails:page];
    
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [super updateSearchResultsForSearchController:searchController];
    
    if (![self.searchString  isEqual: @""]){
        NSString *body = [NSString stringWithFormat:@"advice_title=%@",self.searchString];
        NSDictionary *opInfo = @{@"url":SearchDesignNew,   //按照关键字查找文章
                                 @"body":body};
        
        _operation = [[DANews alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
        
    }
}

@end
