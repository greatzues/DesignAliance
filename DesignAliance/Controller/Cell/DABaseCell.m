//
//  DABaseCell.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseCell.h"



@implementation DABaseCell

- (void)initCell
{
}

- (void)setCellData:(DABaseModel *)info
{
    self.cellInfo = info;
    _titleLabel.text = info.name;
}

@end
