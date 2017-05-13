//
//  DetailsNewsPage.h
//  DesignAliance
//
//  Created by zues on 17/5/12.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABasePage.h"
#import "NewsModel.h"

@interface DetailsNewsPage : DABasePage{

    IBOutlet UIImageView    *imageView;
}

@property(nonatomic, strong)    NewsModel       *newsInfo;

@end
