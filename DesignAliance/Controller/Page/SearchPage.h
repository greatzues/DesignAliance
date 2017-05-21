//
//  SearchPage.h
//  DesignAliance
//
//  Created by zues on 17/5/1.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"
#import "SearchModel.h"
#import "DASearchInfo.h"
#import "MapPage.h"

@interface SearchPage : DABasePage{
    NSInteger   _pageSize;  //显示的item条数
}

@property(nonatomic, strong) SearchModel    *model;
@property(nonatomic, strong) MapPage        *mapPage;

@end
