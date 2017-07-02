//
//  PageModel.m
//  DesignAliance
//
//  Created by zues on 17/4/28.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "PageModel.h"

@implementation PageModel

//将plist的每一条数据加载到字典里面
+ (PageModel *)infoFromDict:(NSDictionary *)dict{
    PageModel *info = [[PageModel alloc] init];
    
    info.ID = [dict objectForKey:@"ClassName"];
    info.name = [dict objectForKey:@"Title"];
    info.image = [dict objectForKey:@"Image"];
    info.selectImage = [dict objectForKey:@"SelectImage"];
    info.unLoad = [[dict objectForKey:@"Unload"] boolValue];
    
    return info;
}

//判断并且读取TarBarPages是否存在，并且遍历里面的数据，返回一个数组对象，每一个数组读取到plist每一个item的所有值
+ (NSArray *)pages{
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"TabBarPages" ofType:@"plist"];
    NSArray *pageConfig = [NSArray arrayWithContentsOfFile:configFile];
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    if (pageConfig.count <= 0) {
        BASE_ERROR_FUN(@"没有配置TabBarPages.plist");
    }
    
    for (NSDictionary *dict in pageConfig) {
        [pages addObject:[PageModel infoFromDict:dict]];
    }
    
    return pages;
}

+ (NSArray *)pageControllers{
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *pages = [PageModel pages];
    UIViewController *pageController = nil;
    UINavigationController *navPage = nil;
    
    //如果在TabBarPages的item上设置了Unload关键字，当为YES时，该item不显示
    for (PageModel *pageInfo in pages) {
        if (pageInfo.unLoad) {
            if (pageInfo.unLoad) {
                continue;
            }
        }
        
        pageController = [[NSClassFromString(pageInfo.ID) alloc] init];
        navPage = [[UINavigationController alloc] initWithRootViewController:pageController];
        
        pageController.title = pageInfo.name;
        pageController.tabBarItem.image = [UIImage imageNamed:pageInfo.image];
        
        [controllers addObject:navPage];
    }

    return controllers;
}

@end
