//
//  DetailsAdvertisement.h
//  DesignAliance
//
//  Created by zues on 2017/6/4.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseDetailsPage.h"
#import "AdvertisementModel.h"

@interface DetailsAdvertisement : DABaseDetailsPage {
    UIWebView       *webView;
}

@property(nonatomic, strong)    UIActivityIndicatorView     *activityIndicator;
@property(nonatomic, strong)    AdvertisementModel          *model;

@end
