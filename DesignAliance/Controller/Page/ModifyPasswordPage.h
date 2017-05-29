//
//  ModifyPasswordPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"

@interface ModifyPasswordPage : DABaseMyPage

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *nPassword;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPassword;

@property (weak, nonatomic) IBOutlet UITextField *comfirmCode;
@property (weak, nonatomic) IBOutlet UIButton *ModifyPasswordButton;

@end
