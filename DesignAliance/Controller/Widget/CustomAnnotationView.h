//
//  CustomAnnotationView.h
//  DesignAliance
//
//  Created by zues on 17/5/10.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"
#import "SearchModel.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic,readonly) CustomCalloutView * calloutView;

@end
