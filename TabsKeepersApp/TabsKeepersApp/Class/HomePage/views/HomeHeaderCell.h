//
//  HomeHeaderCell.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/28.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderCell : UITableViewCell

@property (nonatomic ,copy)void (^didSelectItemBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
