//
//  BottomView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomView : UIView

@property (nonatomic ,strong)UIButton *button;
/**
 点击回调
 */
@property (nonatomic ,copy)void(^clickHandler)(void);


/**
 title. default is "操作"
 */
@property (nonatomic ,copy)NSString *btnTitle;
@end

NS_ASSUME_NONNULL_END
