//
//  DAUploadAvatar.m
//  DesignAliance
//
//  Created by zues on 17/5/5.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAUploadAvatarWidget.h"
#import "DAUploadAvatar.h"

//相机返回的结果  如果结果为0 则获取相机成功  为1  则获取相机失败   下边会有说明
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

@interface DAUploadAvatarWidget () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak)UIImageView *imgV;

@end

@implementation DAUploadAvatarWidget


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)changeImg{
    //这个主要实现点击图片框  弹出选择是相机拍照 还是  相册选择照片
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //等于0 则说明获取相机成功
        if(SIMULATOR == 0){
            /**
             其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
             */
            UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
            //获取方式:通过相机
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            PickerImage.allowsEditing = YES;
            PickerImage.delegate = self;
            [self presentViewController:PickerImage animated:YES completion:nil];
        }
        
        if(SIMULATOR == 1){
            UIAlertController *alertpz = [UIAlertController alertControllerWithTitle: @"DSB?" message:@"别XJB乱点，模拟器上有相机？" preferredStyle:UIAlertControllerStyleAlert];
            [alertpz addAction:[UIAlertAction actionWithTitle:@"我错了" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertpz animated:YES completion:nil];
            
        }
        
    }
                      ]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//PickerImage完成后的代理方法  取出图片  实现赋值
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.imgV.image = newPhoto;
    
    [DAUploadAvatar upload:newPhoto];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
