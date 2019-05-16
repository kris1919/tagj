//
//  NewRepairCell1.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewRepairCell1 : UITableViewCell

@property (nonatomic ,copy)void (^selectBtnClicked)(void);

@property (nonatomic ,copy)void (^textViewDidEndEditing)(NSString *text);

@property (nonatomic ,copy)NSString *selectStr;

@end

NS_ASSUME_NONNULL_END
