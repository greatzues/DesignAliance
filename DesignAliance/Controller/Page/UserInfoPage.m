//
//  UserInfoPage.m
//  DesignAliance
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "UserInfoPage.h"
#import "UserInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+extension.h"
#import "DARegister.h"
#import "MyPage.h"
#import <CRToast/CRToast.h>
#import "DAUploadAvatar.h"

//相机返回的结果  如果结果为0 则获取相机成功  为1  则获取相机失败   下边会有说明
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

@interface UserInfoPage () <UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define BACKGROUND_BLACK_COLOR [UIColor colorWithRed:0.412 green:0.412 blue:0.412 alpha:0.7]
static const int pickerViewHeight = 250;
static const int toolBarHeight = 44;

@implementation UserInfoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setNavigationRight:@"NavigationBell.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




- (void)initData{
    self.topUserInfoTable.delegate      = self;
    self.topUserInfoTable.dataSource    = self;
    self.userDescription.delegate       = self;
    
    if(![self.model.education isEqual:[NSNull null]]){
        self.userEducation.text = self.model.education;
    }
    
    if(![self.model.skill isEqual:[NSNull null]]){
        self.userSkill.text = self.model.skill;
    }
    
    if(![self.model.name isEqual:[NSNull null]]){
        self.username = self.model.name;
    }
    
    if(![self.model.education isEqual:[NSNull null]]){
        self.education = self.model.education;
    }
    
    if([self.model.sex isEqual:[NSNull null]]){
        self.model.sex = @"m";
    }else{
        self.sex = self.model.sex;
    }
}
#pragma 绘制弹出的pickerView界面
- (void)initPickView{
    self.array = [NSArray arrayWithObjects:@"中专",@"大专",@"本科",@"硕士",@"博士",@"博士后", nil];
    
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - pickerViewHeight, SCREEN_WIDTH, pickerViewHeight)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -70, 5, 40, 30)];
    btnOK.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(pickerViewBtnOk:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btnOK];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(30, 5, 40, 30)];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:btnCancel];
    
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, pickerViewHeight - toolBarHeight)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.delegate = self;
    pickView.dataSource = self;
    [self.containerView addSubview:pickView];
    
    self.view.backgroundColor = BACKGROUND_BLACK_COLOR;
    [self.view addSubview:self.containerView];
}

- (IBAction)chooseEducation:(id)sender {
    [self initPickView];
}

#pragma UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.array.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _userEducation.text = [self.array objectAtIndex:row];
    self.educationTemp = [self.array objectAtIndex:row];
}

#pragma mark - UIPickerView event response
- (void)pickerViewBtnOk:(UIButton *)btn{
    self.education = self.educationTemp;
    [self.containerView removeFromSuperview];
}

- (void)pickerViewBtnCancel:(UIButton *)btn{
    [self.containerView removeFromSuperview];
}

#pragma UITableView method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoCell *cell=[UserInfoCell setupCellWith:tableView AtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
        {
            NSString *imageURL = [NSString stringWithFormat:ImageAvatar,self.model.avatar];
            self.userAvatar = cell.userAvatar;
            [cell.userAvatar was_setCircleImageWithUrlString:imageURL placeholder:[UIImage imageNamed:@"LittlePictureHolder.png"] fillColor:[UIColor whiteColor]];
        }
            break;
        case 1:
            if(![self.model.name isEqual:[NSNull null]]){
                cell.userName.text = self.model.name;
            }
            break;
        case 2:
        {
            if([self.model.sex isEqualToString:@"f"]){
                cell.userSex.selectedSegmentIndex = 1;
            }else{
                cell.userSex.selectedSegmentIndex = 0;
            }
            
            [cell.userSex addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        }
            break;
        default:
            break;
            
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch ([indexPath row]) {
        case 0:
        {
            //更换头像
            [self changeImg];
        }
            break;
        case 1:
        {
            //修改名字
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改名字" message:@"请输入你喜欢的名字" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入你喜欢的名字";
                textField.borderStyle = UITextBorderStyleNone;
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction     = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField *Username = alertController.textFields.firstObject;
                self.username = Username.text;
                
                UserInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.userName.text = Username.text;
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 2:
        {
            //设置性别
        }
            break;
        default:
            break;
    }
}


#pragma segmentedControl Action
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger se = Seg.selectedSegmentIndex;
    if(se == 0){
        self.sex = @"m";
    }else{
        self.sex = @"f";
    }
}

#pragma UITextView method
- (void)textViewDidChange:(UITextView *)textView{
    if(textView.tag == 0){
        self.userSkill.text = textView.text;
    }else{
        self.userDescription.text = textView.text;
    }
}

#pragma Uplpad Avatar method
- (void)changeImg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //等于0 则说明获取相机成功
        if(SIMULATOR == 0){
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            [self presentViewController:PickerImage animated:YES completion:nil];
        }
        
        if(SIMULATOR == 1){
            UIAlertController *alertpz = [UIAlertController alertControllerWithTitle: @"DSB?" message:@"别乱点人家，模拟器上有相机？" preferredStyle:UIAlertControllerStyleAlert];
            [alertpz addAction:[UIAlertAction actionWithTitle:@"我错了" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertpz animated:YES completion:nil];
        }
        
    }
    ]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma PickerImage delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.userAvatar.image = newPhoto;
    
    [DAUploadAvatar upload:newPhoto];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma NavigationRight Action
- (void)doRight:(id)sender{
    NSString *body = [NSString stringWithFormat:@"username=%@&sex=%@&description=%@&skill=%@&education=%@",
                      self.username,
                      self.sex,
                      self.userDescription.text,
                      self.userSkill.text,
                      self.education];
    
    
    NSDictionary *opInfo = @{@"url":ModifyInfo,
                             @"body":body};
    _operation = [[DARegister alloc] initWithDelegate:self opInfo:opInfo];
    [_operation executeOp];
}

-(void)opSuccess:(id)data{
    self.ToastTitle = @"信息更新成功";
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    MyPage  *page = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                                    [page initData];
                                    [self.navigationController popToViewController:page animated:YES];
                                }];
}

- (void)opFail:(NSString *)errorMessage{
    self.ToastTitle = @"修改信息出错，请检查网络后重试！";
    [CRToastManager showNotificationWithOptions:self.setToast
                                completionBlock:^{
                                    
                                }];
}

@end
