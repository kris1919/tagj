//
//  HomeParkViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HomeParkViewController.h"
#import <Masonry.h>

@interface HomeParkViewController ()

@end

@implementation HomeParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"停车缴费";
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"答题_暂无数据"];
        imageView;
    });
    UILabel *label = ({
        UILabel *label = [UILabel new];
        label.text = @"上新中";
        label;
    });
    [self.view addSubview:imageView];
    [self.view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
    }];
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
