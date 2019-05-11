//
//  TKBaseViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKBaseViewController.h"
#import <Masonry.h>

@interface TKBaseViewController ()

@end

@implementation TKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self.mc_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat x = [self statusBarHeight];
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@(x+44));
    }];
    __weak __typeof(self) weakSelf = self;
    self.mc_navigationBar.backButtonHandle = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    if (self.navigationController.childViewControllers.count == 1) {
        self.mc_navigationBar.hideBackBtn = YES;
    }
}

-(MCNavigationBarView *)mc_navigationBar{
    if (!_mc_navigationBar) {
        _mc_navigationBar = [[MCNavigationBarView alloc] init];
        [self.view addSubview:_mc_navigationBar];
    }
    return _mc_navigationBar;
}

- (CGFloat)statusBarHeight{
    return kIPhoneXSeries ? 44 : 20;
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
