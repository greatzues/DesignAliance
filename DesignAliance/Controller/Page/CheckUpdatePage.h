//
//  CheckUpdatePage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"

@interface CheckUpdatePage : DABaseMyPage
@property (weak, nonatomic) IBOutlet UILabel *currentVersion;
@property (weak, nonatomic) IBOutlet UILabel *latestVersion;
@property (weak, nonatomic) IBOutlet UIButton *requireLatestVersion;
@property (weak, nonatomic) IBOutlet UITextView *VersionNews;

@end
