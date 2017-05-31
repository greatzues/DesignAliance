//
//  DAUploadAvatar.h
//  DesignAliance
//
//  Created by zues on 17/5/5.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseOperation.h"

@interface DAUploadAvatar : DABaseOperation

+ (void)upload:(UIImage *)photo;
+ (NSData *)setHTTPBodyWithImage:(UIImage *)image boundary:(NSString *)boundary;

@end
