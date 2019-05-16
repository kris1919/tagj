//
//  ServiceListViewCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceListViewCell : UITableViewCell

@property (nonatomic ,strong)ServerListModel *model;


@end

NS_ASSUME_NONNULL_END
