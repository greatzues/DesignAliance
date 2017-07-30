//
//  BecomeVipPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"

@interface BecomeVipPage : DABaseMyPage
@property (weak, nonatomic) IBOutlet UIButton *BecomeVipButton;
@property (weak, nonatomic) IBOutlet UILabel *VipType;

@property (strong, nonatomic) NSString  *phoneNumber;

@end
