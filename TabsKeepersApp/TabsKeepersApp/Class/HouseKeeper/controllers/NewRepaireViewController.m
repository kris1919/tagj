//
//  NewRepaireViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/29.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NewRepaireViewController.h"
#import "TKTableView.h"
#import "NewRepairCell1.h"
#import "NewRepairCell2.h"
#import "NewRepairCell3.h"
#import <Masonry.h>
#import "TKTableViewFooterView.h"

@interface NewRepaireViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)TKTableViewFooterView *footerView;

@end

@implementation NewRepaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"业主报修";
    // Do any additional setup after loading the view.
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NewRepairCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell1" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        NewRepairCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell2" forIndexPath:indexPath];
        cell.canEditing = YES;
        return cell;
    }else{
        NewRepairCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell3" forIndexPath:indexPath];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 222;
    }
    if (indexPath.section == 1) {
        return 126;
    }
    return 152;
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
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [_tableView registerNib:[UINib nibWithNibName:@"NewRepairCell1" bundle:nil] forCellReuseIdentifier:@"NewRepairCell1"];
        [_tableView registerClass:[NewRepairCell2 class] forCellReuseIdentifier:@"NewRepairCell2"];
        [_tableView registerNib:[UINib nibWithNibName:@"NewRepairCell3" bundle:nil] forCellReuseIdentifier:@"NewRepairCell3"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tap];
    }
    return _tableView;
}
- (void)tap{
    [self.view endEditing:YES];
}

-(TKTableViewFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[TKTableViewFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _footerView.imageName = @"icon_evaluate_submit";
        _footerView.btnTitle = @"提交申请";
        _footerView.buttonActionBlock = ^(UIButton * _Nonnull btn) {
            
        };
    }
    return _footerView;
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
