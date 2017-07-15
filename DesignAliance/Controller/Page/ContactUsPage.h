//
//  ContactUsPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"

@interface ContactUsPage : DABaseMyPage

@property (weak, nonatomic) IBOutlet UIButton *phoneNumberText;
@property (strong, nonatomic) NSString  *phoneNumber;

@end
