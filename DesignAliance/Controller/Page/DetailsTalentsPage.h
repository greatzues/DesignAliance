//
//  DetailsTalentsWidget.h
//  DesignAliance
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseDetailsPage.h"
#import "TalentsModel.h"

@interface DetailsTalentsPage : DABaseDetailsPage

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel     *name;
@property (weak, nonatomic) IBOutlet UILabel     *sex;
@property (weak, nonatomic) IBOutlet UILabel     *contact;
@property (weak, nonatomic) IBOutlet UILabel     *education;
@property (weak, nonatomic) IBOutlet UILabel     *skill;
@property (weak, nonatomic) IBOutlet UILabel      *desc;

@property (nonatomic, strong) TalentsModel       *model;

@end
