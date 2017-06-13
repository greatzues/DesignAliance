//
//  DABaseSearchPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"

@interface DABaseSearchPage : DABasePage<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>{

    NSInteger   _pageSize;  //显示的item条数
}

//searchController
@property (nonatomic,retain) UISearchController *searchController;

//tableView
@property (nonatomic,strong) UITableView *skTableView;

//数据源
@property (nonatomic,strong) NSMutableArray *dataListArry;
@property (nonatomic,strong) NSMutableArray *searchListArry;

@property (nonatomic,strong) NSString       *searchString;

- (void)initData;
- (void)initTableView;

@end
