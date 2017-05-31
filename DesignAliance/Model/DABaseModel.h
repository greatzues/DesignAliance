//
//  DABaseModel.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DABaseModel : NSObject

@property(nonatomic, strong) NSString   *ID;
@property(nonatomic, strong) NSString   *name;

+ (instancetype)infoFromDict:(NSDictionary *)dict;
+ (NSArray *)arrayFromDict:(NSDictionary *)dict;
+ (NSArray *)arrayFromArray:(NSArray *)array;

@end
