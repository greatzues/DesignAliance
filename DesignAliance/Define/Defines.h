//
//  Defines.h
//  DesignAliance
//
//  Created by zues on 17/4/22.
//  Copyright © 2017年 zues. All rights reserved.
//



#if (DEBUG || TESTCASE)
#define FxLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define FxLog(format, ...)
#endif

// 日志输出宏
#define BASE_LOG(cls,sel) FxLog(@"%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel))
#define BASE_ERROR_LOG(cls,sel,error) FxLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel), error)
#define BASE_INFO_LOG(cls,sel,info) FxLog(@"INFO:%@-%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel), info)

// 日志输出函数
#if (DEBUG || TESTCASE)
#define BASE_LOG_FUN()         BASE_LOG([self class], _cmd)
#define BASE_ERROR_FUN(error)  BASE_ERROR_LOG([self class],_cmd,error)
#define BASE_INFO_FUN(info)    BASE_INFO_LOG([self class],_cmd,info)
#else
#define BASE_LOG_FUN()
#define BASE_ERROR_FUN(error)
#define BASE_INFO_FUN(info)
#endif

// 设备类型判断
#define IsiPad     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsiPhone   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsRetain   ([[UIScreen mainScreen] scale] >= 2.0)
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxLength (MAX(ScreenWidth, ScreenHeight))
#define ScreenMinLength (MIN(ScreenWidth, ScreenHeight))

#define IsiPhone4   (IsiPhone && ScreenMaxLength < 568.0)
#define IsiPhone5   (IsiPhone && ScreenMaxLength == 568.0)
#define IsiPhone6   (IsiPhone && ScreenMaxLength == 667.0)
#define IsiPhone6P  (IsiPhone && ScreenMaxLength == 736.0)

/*网络请求，这里需要根据服务器进行修改
 {result:ok, data:data}
 {result:error,message:""}
 {result:invalidatetoken, message:"token失效"}
 */
#define NetCode             @"code"
#define NetOk               @"20000"
#define NetData             @"data"
#define NetMessage          @"message"
#define NetDataList         @"datalist"
#define NetVallidateteToken @"invalidatetoken"
#define HTTPSchema          @"http:"
#define HTTPGET             @"GET"
#define HTTPPOST            @"POST"
#define DARequestTimeout    10

//ios系统版本
#define IOSBaseVersion10    10.0
#define IOSBaseVersion9     9.0
#define IOSBaseVersion8     8.0
#define IOSBaseVersion7     7.0
#define IOSBaseVersion6     6.0

//文件缓存路径
#define RootPath            @"/Library/.DesignAliance"
#define CacheImagePath      @"CacheImages"
#define DesignIconPrex      @"DesignIcon_%@"
#define DADBFile            @"DesignAliance.db"

//资讯页面
#define TitleArray          @[@"设计资讯", @"设计任务", @"设计人才"]
#define ViewArray           @[@"DADesignNewsWidget", @"DADesignMissionWidget", @"DADesignTalentsWidget"]

//高德地图
#define AMapKey             @"843b615d0689c272594bb226b4efa96d"


//提示信息
#define LoginingTip         @"登录中..."
#define loadingTip          @"加载中"
#define LoginCheckTip       @"用户名和密码不能为空"
#define LoginTitle          @"登录网易新闻"

// 其他常量
#define AnimationSecond     1.0
#define NavBarHeight        44
#define NavBarHeight7       64
#define LocationDistance    100


