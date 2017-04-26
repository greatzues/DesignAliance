//
//  URLDefine.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//



// 0正式版，1测试版
#define ProductType 1

// 正式版自动使用正式环境
#ifdef OFFICIAL
#undef ProductType
#define ProductType 0
#endif

//上线记得要将Host和Port改回来
#if ProductType == 0
#define BaseHost     @"http://"
#define BasePort    @""
#else
#define BaseHost    @"http://139.199.165.150"
#define BasePort    @":8080"
#endif

#define BaseServer  BaseHost BasePort
#define BaseURLPath "/Design/"
#define BaseURL     BaseServer BaseURLPath

#define LoginURL    BaseURL "Home/User/login"
