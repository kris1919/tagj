//
//  FamilyTableViewCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFamilyListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FamilyTableViewCell : UITableViewCell

@property (nonatomic ,strong)MyFamilyListModel *model;


@end

NS_ASSUME_NONNULL_END
