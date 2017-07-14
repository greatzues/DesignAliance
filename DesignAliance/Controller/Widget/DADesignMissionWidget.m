//
//  DADesignMissionWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//


#import "DADesignMissionWidget.h"
#import "MissionModel.h"
#import "DAMission.h"
#import "DesignMissionCell.h"
#import "DetailsMissionPage.h"

@implementation DADesignMissionWidget

- (void)viewDidLoad {
    self.cellIdentifier = @"DesignMissionCell";
    self.listData = [[NSMutableArray alloc] init];  //初始化设计任务数组
    
    [super viewDidLoad];
    
    _cellHeight= 80;
}   

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadNewData
{
    _pageNo = 1;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":MissionURL,
                               @"body":body,
                               };
    
    _operation = [[DAMission alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)loadMoreData
{
    ++_pageNo;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":MissionURL,
                               @"body":body
                               };
    
    _operation = [[DAMission alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)opSuccess:(NSArray *)data
{
    _operation = nil;
    
    if (_pageNo == 1) {
        [self.listData removeAllObjects];
    }
    [self.listData addObjectsFromArray:data];
    
    //保存第一条任务ID
    MissionModel *model = [self.listData objectAtIndex:0];
    NSInteger advice = [model.ID integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger:advice forKey:@"missionId"];
    
    [super opSuccess:data];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    DABaseModel *info = nil;
    
    cellIdentifier = self.cellIdentifier;
    info = [self.listData objectAtIndex:indexPath.row];
    
    DABaseCell *cell = (DABaseCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    
    [cell setCellData:info];
    
    return cell;
}

#pragma item点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsMissionPage *page = [[DetailsMissionPage alloc] init];
    
    page.model = [self.listData objectAtIndex:indexPath.row];
    [super initToDetails:page];
}


@end
