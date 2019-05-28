//
//  ZhiFuView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/14.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhiFuView : UIView

@property (nonatomic ,copy)void (^payBlock)(NSInteger type);

- (void)show;

- (void)hidde;

@end

NS_ASSUME_NONNULL_END
