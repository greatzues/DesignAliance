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
#import "UserInfoPage.h" //测试注册界面

#import "ModifyPasswordPage.h"
#import "ContactUsPage.h"
#import "BecomeVipPage.h"
#import "CheckUpdatePage.h"
#import "AboutPage.h"
#import "UserSuggestPage.h"

#import <SDWebImage/UIButton+WebCache.h>

@implementation MyPage
@synthesize list = _list;
@synthesize IconList = _IconList;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setNavigationRight:@"logout.png"];
    [self setNavBarImage];
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
    self.list = MyPageArray;
    self.IconList = MyPageIconArray;
    
    //添加头像按钮的监听事件
    [UserAvatar addTarget:self action:@selector(avatarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *opInfo = @{@"url":GetUserInfo,
                             @"body":@""};
    
    _operation = [[DAGetUserInfo alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

- (void)opSuccess:(UserModel *)data{
    [super opSuccess:data];
    self.model = data; //将拿到的数据赋值给model
    
    [UserName setText:self.model.name];
    NSString *imageURL = [NSString stringWithFormat:ImageAvatar,self.model.avatar];
    
    [UserAvatar sd_setBackgroundImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userDefaultAvatar.png"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    //实现cell复用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
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
    switch ([indexPath row]) {
        case 0:
        {
            //成为vip
            BecomeVipPage *modityPassword = [[BecomeVipPage alloc] init];
            [self initToDetails:modityPassword];
        }
            break;
        case 1:
        {
            //修改密码
            ModifyPasswordPage *modityPassword = [[ModifyPasswordPage alloc] init];
            [self initToDetails:modityPassword];
        }
            break;
        case 2:
        {
            //版本更新
            CheckUpdatePage *modityPassword = [[CheckUpdatePage alloc] init];
            [self initToDetails:modityPassword];
        }
            break;
        case 3:
        {
            //联系我们
            ContactUsPage *modityPassword = [[ContactUsPage alloc] init];
            [self initToDetails:modityPassword];
        }
            break;
        case 4:
        {
            //意见反馈
            UserSuggestPage *modityPassword = [[UserSuggestPage alloc] init];
            [self initToDetails:modityPassword];
        }
            break;
        case 5:
        {
            //关于
            AboutPage *modityPassword = [[AboutPage alloc] init];
            [self initToDetails:modityPassword];
        }
            break;
        case 6:
        {
            //分享应用
            
        }
            break;
            
        default:
            break;
    }
}

//头像的点击事件
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

@end
