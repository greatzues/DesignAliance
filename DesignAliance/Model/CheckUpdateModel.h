//
//  CheckUpdateModel.h
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseModel.h"

@interface CheckUpdateModel : DABaseModel

@property(strong, nonatomic) NSString   *version;
@property(strong, nonatomic) NSString   *versionInfo;
@property(strong, nonatomic) NSNumber   *versionId;

@end
