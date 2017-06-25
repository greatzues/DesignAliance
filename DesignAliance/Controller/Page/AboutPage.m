//
//  AboutPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "AboutPage.h"

@implementation AboutPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _IntroduceUsLabel.text = self.IntroduceUs;
    _OurSloganLabel.text = self.OurSlogan;
    _OurTargetLabel.text = self.OurTarget;

    self.TeamMateLabel.numberOfLines = 0;
    for (int i = 0 ; i < [self.member count]; i++){
        self.TeamMateLabel.text = [NSString stringWithFormat:@"%@ %@",self.TeamMateLabel.text,[self.member objectAtIndex:i]];
    }
    
    self.guidanceLabel.numberOfLines = 0;
    for (int i = 0 ; i < [self.guidance count]; i++){
        self.guidanceLabel.text = [NSString stringWithFormat:@"%@\n%@",self.guidanceLabel.text,[self.guidance objectAtIndex:i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
