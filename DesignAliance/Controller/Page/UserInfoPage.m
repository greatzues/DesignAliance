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

@interface UserInfoPage () <UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDelegate>

@end

@implementation UserInfoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData{
    self.topUserInfoTable.delegate = self;
    self.topUserInfoTable.dataSource = self;
}

- (void)initPickView{
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 100, ScreenWidth, ScreenHeight)];
    self.array = [NSArray arrayWithObjects:@"本科",@"大学", nil];
    
    pickView.delegate = self;
    pickView.dataSource = self;
    [self.view addSubview:pickView];
}

- (IBAction)chooseEducation:(id)sender {
    
}

#pragma UIPickerView
//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return self.array.count;
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [self.array objectAtIndex:row];
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    // 使用一个UIAlertView来显示用户选中的列表项
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:[NSString stringWithFormat:@"你选中的球队是：%@"
                                   , [ self.array objectAtIndex:row]]
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
}

#pragma UITableView method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoCell *cell=[UserInfoCell setupCellWith:tableView AtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
        {
            NSString *imageURL = [NSString stringWithFormat:ImageTalents,self.model.avatar];
            
            [cell.userAvatar was_setCircleImageWithUrl:[NSURL URLWithString:imageURL] placeholder:[UIImage imageNamed:@"NewsDefault.png"] fillColor:[UIColor whiteColor]];
        }
            break;
        case 1:
            cell.userName.text = self.model.name;
            break;
        case 2:
        {
            //NSArray *sexItem = @[@"男",@"女"];
            //cell.userSex = [[UISegmentedControl alloc] initWithItems:sexItem];
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
//拿到性别
- (void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger se = Seg.selectedSegmentIndex;
    self.sex = [Seg titleForSegmentAtIndex:se];
}



@end
