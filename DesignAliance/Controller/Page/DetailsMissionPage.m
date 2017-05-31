//
//  DetailsMissionPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DetailsMissionPage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DAGetCountUp.h"

@interface DetailsMissionPage ()

@end

@implementation DetailsMissionPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMissionPage{
    self.missionTitle.text = self.model.name;
    self.missionTime.text = self.model.time.stringValue; //后面再转化时间戳
    self.missionCount.text = self.model.count.stringValue;
    self.missionDetails.numberOfLines = 5;
    self.missionDetails.text = self.model.details;
    self.missionIssuer.text = self.model.issuer;
    self.missionContact.text = self.model.contact;
    
    NSString *imageURL = [NSString stringWithFormat:ImageMission,self.model.cover];
    [self.missionCover sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"NewsDefault.png"] options:SDWebImageRetryFailed];
}

- (void)getCount{
    NSString *body = [NSString stringWithFormat:@"id=%@",self.model.ID];
    NSDictionary *opInfo = @{@"url":GetCountup,
                             @"body":body};
    
    _operation = [[DAGetCountUp alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

-(void)opSuccess:(id)data{
    [super opSuccess:data];
    [self initMissionPage];
    
}

@end
