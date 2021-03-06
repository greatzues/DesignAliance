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

//系统版本号是否大于8.0,低于8.0的系统版本中使用UIAlertController会崩溃
#define IS_SystemVersionGreaterThanEight  ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)

/*网络请求，这里需要根据服务器进行修改
 {result:ok, data:data}
 {result:error,message:""}
 {result:invalidatetoken, message:"token失效"}
 */
#define NetCode             @"code"
#define NetOk               @"20000"
#define NetData             @"data"
#define NetMessage          @"message"
#define NetDataList         @"dataList"
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
#define NewsIconPrex        @"DesignIcon_%@"
#define DADBFile            @"DesignAliance.db"

//资讯页面
#define TitleArray          @[@"设计资讯", @"项目发布", @"设计/技术人才"]
#define ViewArray           @[@"DADesignNewsWidget", @"DADesignMissionWidget", @"DADesignTalentsWidget"]

//用户页面
#define MyPageArray         @[@"成为vip",@"修改密码",@"版本更新",@"联系我们",@"意见反馈",@"关于",@"分享应用"]
#define MyPageIconArray     @[@"vip.png",@"modifyPassword.png",@"update.png",@"contactUs.png",@"suggestion.png",@"about.png",@"shareBlack.png"]

//高德地图
#define AMapKey             @"843b615d0689c272594bb226b4efa96d"
//Bmob短信验证
#define BombKey             @"a7960f4f28ff203105d06b1997bb4800"
#define VericationCodeTitle @"获取验证码"
#define VericationTemplate  @"设计联盟"

//提示信息
#define LoginingTip         @"登录中..."
#define LoadingTip          @"加载中"
#define LoginCheckTip       @"用户名和密码不能为空"
#define LoginTitle          @"登录设计联盟"
#define AlertTip            @"提示"
#define AlertTitle          @"确定"
#define LoginAnotherPlace   @"账户在异地登录，若非本人操作，请修改密码重新登录"
#define NetError            @"网络异常，请稍后重试"

// 消息通知
#define RegisterNotify(_name, _selector)                    \
[[NSNotificationCenter defaultCenter] addObserver:self  \
selector:_selector name:_name object:nil];

#define RemoveNofify            \
[[NSNotificationCenter defaultCenter] removeObserver:self];

#define SendNotify(_name, _object)  \
[[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];

// 其他常量
#define AnimationSecond     1.0
#define NavBarHeight        44
#define NavBarHeight7       64
#define LocationDistance    100
#define ContactUsNumber     "0750-3536712"

// 消息通知Key
#define NofifyNewsIcon      @"NewsIcon"


