//
//  DetailsNewsPage.h
//  DesignAliance
//
//  Created by zues on 17/5/12.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseDetailsPage.h"
#import "NewsModel.h"

@interface DetailsNewsPage : DABaseDetailsPage {
    UIWebView       *webView;
}

@property(nonatomic, strong)    UIActivityIndicatorView     *activityIndicator;
@property(nonatomic, strong)    NewsModel       *newsInfo;

@end
