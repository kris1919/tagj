//
//  HouseKeeperViewCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/29.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HouseKeeperViewCell : UITableViewCell

@property (nonatomic ,copy)void (^operBtnHandleBlock)(void);


@end

NS_ASSUME_NONNULL_END
