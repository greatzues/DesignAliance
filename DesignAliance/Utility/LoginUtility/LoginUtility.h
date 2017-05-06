//
//  LoginUtility.h
//  DesignAliance
//
//  Created by zues on 17/5/3.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUtility : NSObject
/**
 *    @brief    存储账号和密码
 *    @param     userName     账号内容
 *    @param     password     密码内容
 */
+(void)saveUserName:(NSString *)userName PassWord:(NSString *)password;

/**
 *    @brief    读取密码
 */
+(NSString *)readUserName;

/**
 *    @brief    读取密码
 */
+(NSString *)readPassWord;

/**
 *    @brief    注销帐号
 */
+(void)quitLogin;

@end
