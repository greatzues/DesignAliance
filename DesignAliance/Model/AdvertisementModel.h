//
//  AdvertisementModel.h
//  DesignAliance
//
//  Created by Apple on 2017/5/21.
//  Copyright © 2017年 zues. All rights reserved.
//

/*
 {
 "code": 20000,
 "message": "获取广告成功",
 "data": 4,
 "dataList": [
 {
 "id": 0,
 "issuer": "袂卓工作室",
 "cover": "IMG_0678.jpg",
 "link": "http://mp.weixin.qq.com/s/n5xAVT_t-pHkMa_rkqVwow",
 "contact": "15089837950"
 },
 {
 "id": 2,
 "issuer": "袂卓工作室",
 "cover": "IMG_0679.jpg",
 "link": "http://mp.weixin.qq.com/s/pJDxvCbfCJjOKx_cn0WZHg",
 "contact": "15089837950"
 },
 {
 "id": 3,
 "issuer": "袂卓工作室",
 "cover": "IMG_0680.jpg",
 "link": "http://mp.weixin.qq.com/s/kA-ueg0KmlE4fBHj-_SVQA",
 "contact": "15089837950"
 },
 {
 "id": 4,
 "issuer": "袂卓工作室",
 "cover": "IMG_0681.jpg",
 "link": "http://mp.weixin.qq.com/s/r0Kzc5uIp6KEBpk2nfoO_g",
 "contact": "15089837950"
 }
 ]
 }
 */

#import "DABaseModel.h"

@interface AdvertisementModel : DABaseModel

@property(nonatomic, strong) NSString       *cover;
@property(nonatomic, strong) NSString       *link;
@property(nonatomic, strong) NSString       *contact;


@end
