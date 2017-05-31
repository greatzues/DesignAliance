//
//  DAGlobal.m
//  DesignAliance
//
//  Created by zues on 17/4/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAGlobal.h"
#import <UIKit/UIKit.h>

@implementation DAGlobal

+ (DAGlobal *)global{
    static DAGlobal *s_global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_global = [[DAGlobal alloc] init];
    });
    
    return s_global;
}

- (id)init{
    self = [super init];
    if (self) {
        //在这里做出初始化的操作,下面用小木推送来做示范
//        self.push = [[MiPush alloc] init];
    }
    
    return self;
}

#pragma mark - 系统版本

+ (BOOL)isSystemLowIOS10{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion10 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemLowIOS9{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion9 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemLowIOS8{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion8 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemLowIOS7{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion7 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemLowIOS6{
    UIDevice *device = [UIDevice currentDevice];
    CGFloat systemVer = [[device systemVersion] floatValue];
    if (systemVer - IOSBaseVersion6 < -0.001) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)clientVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  [infoDict objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - 缓存路径

+ (NSString *)getRootPath{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:RootPath];
    [DAFileUtility createPath:path];
    
    return path;
}

+ (NSString *)getCacheImage:(NSString *)fileName{
    NSString *path = [NSString stringWithFormat:@"%@/%@",[DAGlobal getRootPath], CacheImagePath];
    
    [DAFileUtility createPath:path];
    path = [NSString stringWithFormat:@"%@/%@.jpg",path,fileName];
    
    return path;
}

+ (NSString *)getUserDBFile{
    NSString *path = [DAGlobal getRootPath];
    return [path stringByAppendingPathComponent:DADBFile];
}

+ (BOOL)setNotBackUp:(NSString *)filePath{
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSNumber *attrValue = [NSNumber numberWithBool:YES];
    
    [fileURL setResourceValue:attrValue forKey:NSURLIsExcludedFromBackupKey error:&error];
    
    if(error != nil) {
        BASE_ERROR_FUN([error localizedDescription]);
        return NO;
    }
    return YES;
}

#pragma mark - 系统提示

+ (void)alertMessage:(NSString *)message{
    [DAGlobal alertMessageEx:message title:nil okTitle:@"确定" cancelTitle:nil delegate:nil];
}

+ (void)alertMessageEx:(NSString *)message
                 title:(NSString *)title
               okTitle:(NSString *)okTitle
           cancelTitle:(NSString *)cancelTitle
              delegate:(id)delegate{
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                                    message:message delegate:delegate
                          cancelButtonTitle:cancelTitle
                          otherButtonTitles:okTitle, nil];
    
    [alertView show];
}

+ (void)logout{

}



@end
