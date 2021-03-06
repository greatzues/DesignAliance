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
#define BaseHost        @"http://"
#define BasePort        @""
#else
#define BaseHost        @"http://119.29.14.160"
#define BasePort        @":80"
#endif

#define BaseServer      BaseHost BasePort
#define BaseURLPath     "/Design/"
#define BaseURL         BaseServer BaseURLPath

//post url
#define LoginURL        BaseURL "Home/User/login"
#define Register        BaseURL "Home/User/register"
#define ForgetPassword  BaseURL "Home/User/forgetPassword"

#define NewsURL         BaseURL "Home/DesignAdvice/showDesignAdvice"
#define MissionURL      BaseURL "Home/DesignMission/showDesignMission"
#define Advertisement   BaseURL "Home/Advertisement/showAdvertisement"

#define ModifyPassword  BaseURL "Home/User/modifyPassword"
#define CheckUpdate     BaseURL "Home/User/checkUpdate"
#define Logout          BaseURL "Home/User/logout"
#define ModifyInfo      BaseURL "Home/UserInfo/modifyUserInfo"
#define UploadAvatar    BaseURL "Home/UserInfo/uploadAvatar"
#define GetUserInfo     BaseURL "Home/UserInfo/getUserInfo"
#define GetCountup      BaseURL "Home/DesignMission/countUp"
#define GetUserSuggest  BaseURL "Home/UserSuggest/saveSuggestion"
#define GetAboutInfo    BaseURL "Home/About/getAboutInfo"
#define CheckUpdate     BaseURL "Home/User/checkUpdate"
#define GetNotice       BaseURL "Home/Notice/getNotice"
#define ModifyNotice    BaseURL "Home/Notice/modifyNotice"

//Company Post
#define SearchCompanyDefault        BaseURL "Home/Company/searchCompanyLimit"
#define SearchCompanyByKey          BaseURL "Home/Company/searchCompanyByKey"
#define SearchCompanyById           BaseURL "Home/Company/searchCompanyById"

//searchByKey
#define SearchDesignNew             BaseURL "Home/DesignAdvice/searchDesignAdviceByTitle"
#define SearchDesignMission         BaseURL "Home/DesignMission/searchDesignMissionByTitle"

//VIP searchByKey
#define SearchAdviser               BaseURL "VIP/Adviser/searchAdviser"
#define ShowAllAdviser              BaseURL "VIP/Adviser/showAllAdviser"
#define ShowDesignPersion           BaseURL "VIP/DesignPerson/showDesignPerson"
#define SearchDesignTalents         BaseURL "VIP/DesignPerson/searchDesignPersonBySkill"


//get image url
#define GetAvatarImage  BaseURL "Home/UserInfo/getAvatarImage/%@"
#define ImageAvatar     BaseURL "Avatar/%@"
#define ImageNews       BaseURL "DesignAdvice/%@"
#define ImageMission    BaseURL "DesignMission/%@"
#define ImageTalents    BaseURL "DesignPerson/%@"
#define ImageAD         BaseURL "Advertisement/%@"

