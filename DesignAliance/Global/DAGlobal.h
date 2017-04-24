//
//  DAGlobal.h
//  DesignAliance
//
//  Created by zues on 17/4/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAGlobal : NSObject

//系统版本
+ (BOOL)isSystemLowIOS10;
+ (BOOL)isSystemLowIOS9;
+ (BOOL)isSystemLowIOS8;
+ (BOOL)isSystemLowIOS7;
+ (BOOL)isSystemLowIOS6;
+ (NSString *)clientVersion;

//缓存路径
+ (NSString *)getRootPath;
+ (NSString *)getCacheImage:(NSString *)fileName;
+ (NSString *)getUserDBFile;
+ (BOOL)setNotBackUp:(NSString *)filePath;


//系统提示
+ (void)alertMessage:(NSString *)message;
+ (void)alertMessageEx:(NSString *)message
                 title:(NSString *)title
               okTitle:(NSString *)okTitle
           cancelTitle:(NSString *)cancelTitle
              delegate:(id)delagate;

//推出
+ (void)logout;

@end
