//
//  MyPage.m
//  DesignAliance
//
//  Created by zues on 17/4/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "MyPage.h"
#import "DAGetUserInfo.h"
#import "UserModel.h"
#import "DAUploadAvatarWidget.h"
#import "UserInfoPage.h"
#import "DAGetAboutInfo.h"
#import "AboutInfoModel.h"

#import "ModifyPasswordPage.h"
#import "ContactUsPage.h"
#import "BecomeVipPage.h"
#import "CheckUpdatePage.h"
#import "AboutPage.h"
#import "UserSuggestPage.h"
#import "LoginUtility.h"
#import "LoginPage.h"

#import <SDWebImage/UIButton+WebCache.h>
#import "UIImage+extension.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>



@implementation MyPage
@synthesize list = _list;
@synthesize IconList = _IconList;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationRight:@"logout.png"];
    self.list = [NSMutableArray array];
    
    _getAboutInfo = NO;
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.list = nil;
    self.IconList = nil;
}

- (void)initData{
    [_list addObjectsFromArray:MyPageArray];
    self.IconList = MyPageIconArray;
    
    _userGrade = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGrade"];
    if([_userGrade isEqualToString:@"2"]){
        [self.list replaceObjectAtIndex:0 withObject:@"续费"];
    }
    
    //添加头像按钮的监听事件
    [UserAvatar addTarget:self action:@selector(avatarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *opInfo = @{@"url":GetUserInfo,
                             @"body":@""};
    
    _operation = [[DAGetUserInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)getMyPageData{
    
    NSDictionary *opInfo = @{@"url":GetAboutInfo,
                             @"body":@""};
    
    _operation = [[DAGetAboutInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}


- (void)opSuccess:(id)data{
    [super opSuccess:data];
    
    if(_getAboutInfo){
        _getAboutInfo = NO;
        self.AboutInfoModel = data;
        
    }else{
        self.model = data;
        
        if(![self.model.name isEqual:[NSNull null]]){
            [UserName setText:self.model.name];
        }
        
        if(![self.model.skill isEqual:[NSNull null]]){
            [UserSkill setText:self.model.skill];
        }
        NSString *imageURL = [NSString stringWithFormat:ImageAvatar,self.model.avatar];
        
        [UserAvatar sd_setBackgroundImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userDefaultAvatar.png"]];
        
        _getAboutInfo = YES;
        //请求完UserInfo
        [self getMyPageData];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //实现cell复用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    
    //设置cell标题和图片
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    UIImage *image = [UIImage imageNamed:[self.IconList objectAtIndex:row]];
    cell.imageView.image = image;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath row]) {
        case 0:
        {
            //成为vip
            BecomeVipPage *page = [[BecomeVipPage alloc] init];
            page.phoneNumber = self.AboutInfoModel.phone;
            [self initToDetails:page];
        }
            break;
        case 1:
        {
            //修改密码
            ModifyPasswordPage *page = [[ModifyPasswordPage alloc] init];
            [self initToDetails:page];
        }
            break;
        case 2:
        {
            //版本更新
            CheckUpdatePage *page = [[CheckUpdatePage alloc] init];
            [self initToDetails:page];
        }
            break;
        case 3:
        {
            //联系我们
            ContactUsPage *page = [[ContactUsPage alloc] init];
            page.phoneNumber = self.AboutInfoModel.phone;
            
            [self initToDetails:page];
        }
            break;
        case 4:
        {
            //意见反馈
            UserSuggestPage *page = [[UserSuggestPage alloc] init];
            [self initToDetails:page];
        }
            break;
        case 5:
        {
            //关于
            AboutPage *page = [[AboutPage alloc] init];
            page.IntroduceUs = self.AboutInfoModel.brief;
            page.OurSlogan= self.AboutInfoModel.slogan;
            page.OurTarget= self.AboutInfoModel.target;
            page.member = self.AboutInfoModel.member;
            page.guidance = self.AboutInfoModel.guidance;
            
            [self initToDetails:page];
        }
            break;
        case 6:
        {
            //分享应用
            [self shareApp];
        }
            break;
            
        default:
            break;
    }
}

#pragma doRight action
- (void)doRight:(id)sender{
    [LoginUtility quitLogin];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userGrade"];
    
    LoginPage *page = [[LoginPage alloc] init];
    
    page.hidesBottomBarWhenPushed = YES;
    self.tabBarController.selectedIndex = 0;
    [[self.tabBarController.viewControllers objectAtIndex:0] pushViewController:page animated:YES];
}

#pragma avatar click action
- (IBAction)avatarPress:(id)sender{    
    UserInfoPage *page =  [[UserInfoPage alloc] init];
    page.model = self.model;
    [self initToDetails:page];
}

- (void)setNavBarImage{
    UIImage *image = [UIImage imageNamed:@"UserTopBackground.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:18]
                                };
    
    [self.navigationController.navigationBar setTitleTextAttributes:attribute];
}

- (void)shareApp{
    NSArray* imageArray = @[[UIImage imageNamed:@"logo.png"]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"Share SDK http://www.mob.com/"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://zuesblog.xyz/"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state,
                                         SSDKPlatformType platformType,
                                         NSDictionary *userData,
                                         SSDKContentEntity *contentEntity,
                                         NSError *error,
                                         BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
                }
}

@end
