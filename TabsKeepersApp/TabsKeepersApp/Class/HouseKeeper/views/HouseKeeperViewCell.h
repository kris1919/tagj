//
//  HouseKeeperViewCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/29.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaoxiuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HouseKeeperViewCell : UITableViewCell

@property (nonatomic ,copy)void (^operBtnHandleBlock)(NSInteger type,NSInteger index);

@property (nonatomic ,strong)BaoxiuModel *model;

@property (nonatomic ,strong)NSIndexPath *indenPath;


@end

NS_ASSUME_NONNULL_END
