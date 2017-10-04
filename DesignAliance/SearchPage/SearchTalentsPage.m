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
#import "DABaseCell.h"
#import "DesignTalentsCell.h"

@implementation SearchTalentsPage

- (void)initData{
    
//    NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
//    if([userGrade isEqualToString:@"2"]){
//        _pageSize = 10;
//        NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
//        NSDictionary *opInfo = @{@"url":ShowDesignPersion,    //拿到10条新闻资讯
//                                 @"body":body};
//        
//        _operation = [[DATalents alloc] initWithDelegate:self opInfo:opInfo];
//        [_operation executeOp];
//    }else{
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:AlertTip message:@"仅VIP可见" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:AlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alert addAction:okAction];
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
    _pageSize = 10;
    NSString *body = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d",1,10];
    NSDictionary *opInfo = @{@"url":ShowDesignPersion,    //拿到10条新闻资讯
                             @"body":body};
    
    _operation = [[DATalents alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *flag=@"cell";
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    
    static NSString *flag=@"DesignTalentsCell";
    DABaseCell *cell = (DABaseCell*)[tableView dequeueReusableCellWithIdentifier:flag];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (cell==nil) {
        //cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:flag owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
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
    //[cell.textLabel setText:self.model.name];
    [cell setCellData:self.model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
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