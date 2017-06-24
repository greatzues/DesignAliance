//
//  DADesignTalentsWidget.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DATableWidget.h"
#import "TalentsModel.h"

@interface DADesignTalentsWidget : DATableWidget

@property(nonatomic, strong)   TalentsModel          *search;
@property  IBOutlet UIImageView *TalentsPageNormalAcountBackground;


@end
