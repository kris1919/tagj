//
//  PersonCenterViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "TKCycleData.h"
#import "MyFamilyViewController.h"
#import "MyFeeManageViewController.h"
#import "MyNotiManageViewController.h"
#import "ContactsUsViewController.h"

@interface PersonCenterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    self.nameLabel.text = userModel.name;
    self.houseNoLabel.text = userModel.address;
    self.houseAreaLabel.text = userModel.size;
    self.phoneLabel.text = userModel.phone;
}
- (IBAction)familyBtnAction:(UIButton *)sender {
    MyFamilyViewController *vc = [[MyFamilyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)feeBtnAction:(UIButton *)sender {
    MyFeeManageViewController *vc = [[MyFeeManageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)notiBtnAction:(UIButton *)sender {
    MyNotiManageViewController *vc = [[MyNotiManageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)contactBtnAction:(UIButton *)sender {
}
- (IBAction)logoutBtnAction:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [self presentViewController:alertVC animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
