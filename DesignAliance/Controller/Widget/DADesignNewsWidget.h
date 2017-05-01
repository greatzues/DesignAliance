//
//  DADesignNewsWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DATableWidget.h"

@interface DADesignNewsWidget : DATableWidget{
    BOOL        _hasNextPage;
    NSInteger   _pageNo;    //当前页书
    NSInteger   _pageSize;  //显示的item条数
}


@end
