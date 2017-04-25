//
//  URLDefine.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//



//
#ifdef OFFICIAL
#undef ProductType
#define ProductType  0
#endif


#if ProductType == 0
#define BaseHost     @"http://"
#define BasePort    @""
#else
#define BaseHost    @"http://139.199.165.150"
#define BasePort    @":8080/Design/"
#endif
