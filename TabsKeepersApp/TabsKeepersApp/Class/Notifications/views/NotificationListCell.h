//
//  NotificationListCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseNotificationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationListCell : UITableViewCell

@property (nonatomic ,strong)HouseNotificationModel *model;


@end

NS_ASSUME_NONNULL_END
