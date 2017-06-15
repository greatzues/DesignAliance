//
//  DetailsMissionPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseDetailsPage.h"
#import "MissionModel.h"

@interface DetailsMissionPage : DABaseDetailsPage

@property (weak, nonatomic) IBOutlet UILabel        *missionTitle;
@property (weak, nonatomic) IBOutlet UILabel        *missionCount;
@property (weak, nonatomic) IBOutlet UILabel        *missionTime;
@property (weak, nonatomic) IBOutlet UILabel        *missionIssuer;
@property (weak, nonatomic) IBOutlet UILabel        *missionContact;
@property (weak, nonatomic) IBOutlet UIImageView    *missionCover;
@property (weak, nonatomic) IBOutlet UITextView     *missionDetails;

@property(nonatomic, strong) MissionModel           *model;

@end
