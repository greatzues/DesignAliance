//
//  DATableWidget.m
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DATableWidget.h"
#import "DABaseCell.h"


@implementation DATableWidget

- (void)updateUI{
    [_tableView reloadData];
}

#pragma mark - DAOperationDelegate methods

- (void)opSuccess:(id)data{
    [super opSuccess:data];
    
    self.listData = data;
    [self updateUI];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource methods

-(void)tableView:(UITableView *)tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DABaseCell *cell = (DABaseCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:self.cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    
    [cell setCellData:[self.listData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
