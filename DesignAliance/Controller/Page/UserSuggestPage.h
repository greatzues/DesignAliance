//
//  UserSuggestPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"
#import "JVFloatLabeledTextField.h"

@interface UserSuggestPage : DABaseMyPage

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *UserMail;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *SuggestContent;

@end
