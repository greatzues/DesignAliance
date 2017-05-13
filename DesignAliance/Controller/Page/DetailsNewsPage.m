//
//  DetailsNewsPage.m
//  DesignAliance
//
//  Created by zues on 17/5/12.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsNewsPage.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DetailsNewsPage ()

@end

@implementation DetailsNewsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *imageURL = [NSString stringWithFormat:ImageNews,_newsInfo.cover];
    NSLog(@"%@", imageURL);
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"NewsDefault.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
