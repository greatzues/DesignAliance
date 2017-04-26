//
//  UserModel.m
//  DesignAliance
//
//  Created by zues on 17/4/25.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (UserModel *)infoFromDict:(NSDictionary *)dict{
    UserModel *user = [[UserModel alloc] init];
    
    user.ID = [dict objectForKey:@"userId"];
    user.name = [dict objectForKey:@"username"];
    user.sex = [dict objectForKey:@"sex"];
    user.avatar = [dict objectForKey:@"avatar"];
    
    return user;
}

@end
