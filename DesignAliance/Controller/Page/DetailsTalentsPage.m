//
//  DetailsTalentsWidget.m
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsTalentsPage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+extension.h"

@implementation DetailsTalentsPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPage];
    [self setTitle:@"设计人才"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initPage{
    self.name.text = self.model.name;
    self.sex.text = self.model.sex; //后面再转化时间戳
    self.contact.text = self.model.phone;
    self.desc.numberOfLines = 5;
    self.desc.text = self.model.desc;
    self.skill.text = self.model.skill;
    self.education.text = self.model.education;
    
    NSString *imageURL = [NSString stringWithFormat:ImageTalents,self.model.avatar];
//    [self.avatar sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"NewsDefault.png"] options:SDWebImageRetryFailed];
    
    [self.avatar was_setCircleImageWithUrlString:imageURL placeholder:[UIImage imageNamed:@"NewsDefault.png"] fillColor:[UIColor whiteColor]];
}

@end
