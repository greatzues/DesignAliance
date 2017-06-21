//
//  SearchTalentsPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "SearchTalentsPage.h"
#import "DATalents.h"
#import "DetailsTalentsPage.h"

@implementation SearchTalentsPage


- (void)initData{
    
    NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
    if([userGrade isEqualToString:@"2"]){
        _pageSize = 10;
        NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
        NSDictionary *opInfo = @{@"url":ShowDesignPersion,    //拿到10条新闻资讯
                                 @"body":body};
        
        _operation = [[DATalents alloc] initWithDelegate:self opInfo:opInfo];
        [_operation executeOp];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:@"仅VIP可见" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
    
    DetailsTalentsPage *page = [[DetailsTalentsPage alloc] init];
    page.model = self.model;
    [super initToDetails:page];
    
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
