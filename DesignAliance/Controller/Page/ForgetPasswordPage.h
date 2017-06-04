//
//  ForgetPasswordPage.h
//  DesignAliance
//
//  Created by zues on 2017/6/4.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"
#import "JVFloatLabeledTextField.h"

@interface ForgetPasswordPage : DABasePage{
    IBOutlet    JVFloatLabeledTextField     *phoneNumber;
    IBOutlet    JVFloatLabeledTextField     *passwordNumber;
    IBOutlet    JVFloatLabeledTextField     *confirmNumber;
    IBOutlet    JVFloatLabeledTextField     *VerificationCode;
    
    IBOutlet UIButton *getVericationCode;
    IBOutlet UIButton *userRegister;
    
}

@end
