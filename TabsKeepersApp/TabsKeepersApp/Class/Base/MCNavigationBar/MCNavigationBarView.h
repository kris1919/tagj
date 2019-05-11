//
//  MCNavigationBarView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCNavigationBarView : UIView

@property (nonatomic ,copy)void (^backButtonHandle)(void);

@property (nonatomic ,copy)NSString *title;

@property (nonatomic ,assign)BOOL hideBackBtn;

- (void)addRightBarItemWithImage:(UIImage *)image handle:(void(^)(void))handle;

@end

NS_ASSUME_NONNULL_END
