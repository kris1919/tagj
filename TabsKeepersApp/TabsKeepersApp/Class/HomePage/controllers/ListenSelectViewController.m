//
//  ListenSelectViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ListenSelectViewController.h"
#import "TKTableView.h"
#import "ListenListViewCell.h"
#import <Masonry.h>
#import "DHPreviewViewController.h"
#import "DHQueryRecordsViewController.h"
#import "DHLoginManager.h"
@interface ListenSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)NSArray *dataArr;

@end

@implementation ListenSelectViewController

-(void)dealloc{
    [[DHLoginManager sharedInstance] logout:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = @[@"实时监控",@"监控回放"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListenListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListenListViewCell" forIndexPath:indexPath];
    cell.cText = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
    if (indexPath.row == 0) {
        DHPreviewViewController *previewVC = [TKUtils viewControllerWithStory:@"Main" storyId:@"DHPreviewViewController"];
        [self.navigationController pushViewController:previewVC animated:YES];
    }else{
        DHQueryRecordsViewController *previewVC = [TKUtils viewControllerWithStory:@"Main" storyId:@"DHQueryRecordsViewController"];
        [self.navigationController pushViewController:previewVC animated:YES];
    }
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"ListenListViewCell" bundle:nil] forCellReuseIdentifier:@"ListenListViewCell"];
        
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
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
