//
//  LoginUtility.m
//  DesignAliance
//
//  Created by zues on 17/5/3.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "LoginUtility.h"
#import "KeychainItemWrapper.h"

@implementation LoginUtility

+ (void)saveUserName:(NSString *)userName PassWord:(NSString *)password{
    NSString *myUsername = userName;// 获取输入的用户名
    NSString *myPassword = password;// 获取输入的密码
    if (![myUsername isEqualToString:@""] && ![myPassword isEqualToString:@""]) {
        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
        [keychain setObject:myUsername forKey:(__bridge id)(kSecAttrAccount)];
        [keychain setObject:myPassword forKey:(__bridge id)(kSecValueData)];
    }
}

+ (NSString *)readUserName{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];// 通过同样的标志创建keychain
    // 获取对应Key里保存的用户名和密码
    NSString *myUsername = [keychain objectForKey:(__bridge id)(kSecAttrAccount)];
    // 显示
    NSLog(@"----->>%@",myUsername);
    
    return myUsername;
}

+ (NSString *)readPassWord{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];// 通过同样的标志创建keychain
    // 获取对应Key里保存的用户名和密码
    NSString *myPassword = [keychain objectForKey:(__bridge id)(kSecValueData)];
    return myPassword;
}

//当注销的时候将对应的键值设为空字符串，登录时除了判断是否保存帐号或者密码是否存在且是否为空即可
+ (void)quitLogin{
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
    [keychain setObject:@"" forKey:(__bridge id)(kSecAttrAccount)];
    [keychain setObject:@"" forKey:(__bridge id)(kSecValueData)];
}


@end
