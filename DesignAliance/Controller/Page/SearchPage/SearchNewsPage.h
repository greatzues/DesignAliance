//
//  SearchNewsPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseSearchPage.h"
#import "DADesignNewsWidget.h"
#import "NewsModel.h"

@interface SearchNewsPage : DABaseSearchPage

@property(nonatomic, strong) DADesignNewsWidget       *page;
@property(nonatomic, strong) NewsModel                *model;

@end
