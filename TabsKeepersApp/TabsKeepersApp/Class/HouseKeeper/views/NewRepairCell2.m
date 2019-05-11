//
//  NewRepairCell2.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NewRepairCell2.h"
#import "UIFont+PingFangSC.h"
#import "UIColor+Theme.h"
#import "PhotoCollectionCell.h"
#import <Masonry.h>

@interface NewRepairCell2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UICollectionView *collectionView;
@end

@implementation NewRepairCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(self.contentView).offset(16);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(16);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self.contentView).offset(-10);
            make.right.mas_equalTo(self.contentView).offset(-16);
        }];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.canEditing + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionCell" forIndexPath:indexPath];
    if (self.canEditing && (indexPath.row == [collectionView numberOfItemsInSection:0] - 1)) {
        cell.imagePath = @"icon_pic_add";
    }
    return cell;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"图片附件";
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor labelColorLevel51];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (kScreenWidth - 32) / 4;
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCollectionCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

@end
