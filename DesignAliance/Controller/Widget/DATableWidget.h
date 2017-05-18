//
//  DATableWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/29.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseWidget.h"
#import "DABasePage.h"

@interface DATableWidget : DABaseWidget {
    IBOutlet UITableView    *_tableView;
    CGFloat                 _cellHeight;
}

@property(nonatomic, strong) NSString   *cellIdentifier;
@property(nonatomic, assign) id         owner;

@end
