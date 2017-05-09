//
//  RegisterPage.h
//  DesignAliance
//
//  Created by zues on 17/5/6.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"
#import "JVFloatLabeledTextView.h"
#import "JVFloatLabeledTextField.h"

@interface RegisterPage : DABasePage{
    IBOutlet    JVFloatLabeledTextField     *phoneNumber;
    IBOutlet    JVFloatLabeledTextField     *passwordNumber;
    IBOutlet    JVFloatLabeledTextField     *confirmNumber;
    IBOutlet    JVFloatLabeledTextField     *VerificationCode;
    
    IBOutlet UIButton *getVericationCode;
    IBOutlet UIButton *userRegister;
    
}

@end
