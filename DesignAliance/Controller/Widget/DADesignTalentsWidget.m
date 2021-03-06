//
//  DADesignTalentsWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DADesignTalentsWidget.h"
#import "DABaseCell.h"
#import "DATalents.h"
#import "TalentsModel.h"
#import "DetailsTalentsPage.h"

@interface DADesignTalentsWidget ()

@end

@implementation DADesignTalentsWidget

- (void)viewDidLoad {
    NSString *userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
    if([userGrade isEqualToString:@"2"]){
        self.cellIdentifier = @"DesignTalentsCell";
        self.listData = [[NSMutableArray alloc] init];
        
        [super viewDidLoad];
        _cellHeight = 109;
    }else{
        _tableView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        self.TalentsPageNormalAcountBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VIPRight.jpg"]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadNewData
{
    _pageNo = 1;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":ShowDesignPersion,
                               @"body":body,
                               };
    
    _operation = [[DATalents alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)loadMoreData
{
    ++_pageNo;
    
    NSString *body = [NSString stringWithFormat:@"pageNo=%ld&pageSize=%ld",(long)_pageNo,(long)_pageSize];
    NSDictionary *dictInfo = @{@"url":ShowDesignPersion,
                               @"body":body
                               };
    
    _operation = [[DATalents alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)opSuccess:(NSArray *)data
{
    _operation = nil;
    
    if (_pageNo == 1) {
        [self.listData removeAllObjects];
    }
    [self.listData addObjectsFromArray:data];
    
    //保存第一条人才ID
    TalentsModel *model = [self.listData objectAtIndex:0];
    NSInteger advice = [model.ID integerValue];
    [[NSUserDefaults standardUserDefaults] setInteger:advice forKey:@"persionId"];
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

//这个是item点击之后的监听
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsTalentsPage *page = [[DetailsTalentsPage alloc] init];
    
    page.model = [self.listData objectAtIndex:indexPath.row];
    [super initToDetails:page];
}


@end
