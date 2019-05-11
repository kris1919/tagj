//
//  HouseKeeperViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HouseKeeperViewController.h"
#import "NewRepaireViewController.h"
#import "TKTableView.h"
#import "HouseKeeperViewCell.h"
#import <Masonry.h>
#import "TKEvaluateView.h"
#import "RepairedViewController.h"

@interface HouseKeeperViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@end

@implementation HouseKeeperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mc_navigationBar.title = @"天安管家";
    WS(weakSelf);
    [self.mc_navigationBar addRightBarItemWithImage:[UIImage imageNamed:@"icon_add"] handle:^{
        NewRepaireViewController *repairVC = [[NewRepaireViewController alloc] init];
        [weakSelf.navigationController pushViewController:repairVC animated:YES];
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, kTabBar_Height, 0));
    }];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseKeeperViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeeperViewCell" forIndexPath:indexPath];
//    WS(weakSelf);
    cell.operBtnHandleBlock = ^{
        TKEvaluateView *view = (TKEvaluateView *)[TKUtils nibWithNibName:@"TKEvaluateView"];
        [view show];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 196;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepairedViewController *repairedVC = [[RepairedViewController alloc] init];
    [self.navigationController pushViewController:repairedVC animated:YES];
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"HouseKeeperViewCell" bundle:nil] forCellReuseIdentifier:@"HouseKeeperViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
