//
//  DATableWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseWidget.h"
#import "DABasePage.h"
#import "MJRefresh.h"

@interface DATableWidget : DABaseWidget {
    IBOutlet UITableView    *_tableView;
    CGFloat                 _cellHeight;
    
    BOOL        _hasNextPage;
    NSInteger   _pageNo;    //当前页书
    NSInteger   _pageSize;  //显示的item条数
}

@property(nonatomic, strong) NSString   *cellIdentifier;
@property(nonatomic, assign) id         owner;

@property(nonatomic, strong) DABasePage *page;

@property(nonatomic, strong)   MJRefreshGifHeader *header;
@property(nonatomic, strong)   MJRefreshAutoGifFooter *footer;

- (void)loadNewData;
- (void)loadMoreData;
- (void)initToDetails:(DABasePage *)page;

@end
