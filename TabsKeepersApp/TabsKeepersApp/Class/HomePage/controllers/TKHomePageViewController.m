//
//  TKHomePageViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "TKTableView.h"
#import "HomeHeaderCell.h"
#import "HomeNotificationCell.h"
#import "HomeAdvertiseCell.h"
#import <Masonry.h>

@interface TKHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:249 green:249 blue:249 alpha:1.0];
    self.mc_navigationBar.alpha = 0;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kTabBar_Height, 0));
    }];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section < 2 ? 1 : 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell"];
        if (!cell) {
            cell = [[HomeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeHeaderCell"];
        }
        return cell;
    }else if (indexPath.section == 1){
        HomeNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNotificationCell" forIndexPath:indexPath];
        return cell;
    }else{
        HomeAdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAdvertiseCell" forIndexPath:indexPath];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return (254 + (kScreenWidth - 30) * 0.5);
    if (indexPath.section == 1) return 46;
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGFLOAT_MIN : 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"HomeNotificationCell" bundle:nil] forCellReuseIdentifier:@"HomeNotificationCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"HomeAdvertiseCell" bundle:nil] forCellReuseIdentifier:@"HomeAdvertiseCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
