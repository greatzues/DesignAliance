//
//  CheckUpdateModel.h
//  DesignAliance
//
//  Created by zues on 2017/6/24.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {"code":20000,
 "message":"获取版本信息成功",
 "data":{
 "id":0,
 "version":"1.3.1",
 "info":"fix bug"},
 "dataList":null}
 */

#import "DABaseModel.h"

@interface CheckUpdateModel : DABaseModel

@property(strong, nonatomic) NSString   *version;
@property(strong, nonatomic) NSString   *versionInfo;
@property(strong, nonatomic) NSNumber   *versionId;

@end
