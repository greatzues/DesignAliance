//
//  DesignTalentsCell.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseCell.h"

@interface DesignTalentsCell : DABaseCell{
    IBOutlet UIImageView       *_imageView;
    IBOutlet UILabel           *_phoneLabel;
    IBOutlet UILabel           *_skillLabel;
    IBOutlet UIImageView       *_twoImageView; //左边第二张图标
    IBOutlet UIImageView       *_threeImageView; //左边第三张小图标
    
}


@end
