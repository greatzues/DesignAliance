//
//  DABaseCell.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DABaseModel.h"

@interface DABaseCell : UITableViewCell{
IBOutlet UILabel        *_titleLabel;
}

@property(nonatomic, strong) DABaseModel   *cellInfo;

- (void)initCell;
- (void)setCellData:(DABaseModel *)info;
- (NSString *)dateToTime:(NSString *)d;

@end
