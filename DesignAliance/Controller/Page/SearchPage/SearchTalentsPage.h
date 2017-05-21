//
//  SearchTalentsPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseSearchPage.h"
#import "DADesignTalentsWidget.h"
#import "TalentsModel.h"

@interface SearchTalentsPage : DABaseSearchPage

@property(nonatomic, strong) DADesignTalentsWidget       *page;
@property(nonatomic, strong) TalentsModel                *model;

@end
