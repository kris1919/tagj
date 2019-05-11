//
//  PersonCenterViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "PersonCenterViewController.h"

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
}
- (IBAction)familyBtnAction:(UIButton *)sender {
}
- (IBAction)feeBtnAction:(UIButton *)sender {
}
- (IBAction)notiBtnAction:(UIButton *)sender {
}
- (IBAction)contactBtnAction:(UIButton *)sender {
}
- (IBAction)logoutBtnAction:(UIButton *)sender {
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
