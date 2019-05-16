//
//  NewRepairCell3.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewRepairCell3 : UITableViewCell

@property (nonatomic ,copy)void (^textFieldDidEndEditing)(NSString *text,NSInteger tag);

@end

NS_ASSUME_NONNULL_END
