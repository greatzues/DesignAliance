//
//  HomePage.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseOperation.h"

@interface HomePage : UITabBarController <UITabBarDelegate, DAOperationDelegate>{
    UITabBarItem *secondItem;
    DABaseOperation *_operation;
    
    NSNumber *adviceId;
    NSNumber *missionId;
    NSNumber *personId;
}

@end
