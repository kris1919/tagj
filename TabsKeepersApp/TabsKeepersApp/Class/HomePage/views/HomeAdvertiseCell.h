//
//  HomeAdvertiseCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/28.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAdModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeAdvertiseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@property (nonatomic ,strong)HomeAdModel *model;

@end

NS_ASSUME_NONNULL_END
