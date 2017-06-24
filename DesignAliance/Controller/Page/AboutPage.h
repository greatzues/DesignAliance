//
//  AboutPage.h
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseMyPage.h"

@interface AboutPage : DABaseMyPage
@property (weak, nonatomic) IBOutlet UITextView *IntroduceUsLabel;
@property (weak, nonatomic) IBOutlet UILabel *OurSloganLabel;
@property (weak, nonatomic) IBOutlet UILabel *OurTargetLabel;
@property (weak, nonatomic) IBOutlet UILabel *TeamMateLabel;
@property (weak, nonatomic) IBOutlet UILabel *guidanceLabel;

@property (strong, nonatomic) NSArray     *member;
@property (strong, nonatomic) NSArray     *guidance;
@property (strong, nonatomic) NSString    *IntroduceUs;
@property (strong, nonatomic) NSString    *OurSlogan;
@property (strong, nonatomic) NSString    *OurTarget;

@end
