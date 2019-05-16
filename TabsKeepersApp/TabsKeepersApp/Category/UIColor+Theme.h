//
//  UIColor+Theme.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Theme)

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)alpha;

+ (UIColor *)labelColorLevel51;

+ (UIColor *)labelColorLevel153;

+ (UIColor *)labelColorLevel102;

+ (UIColor *)tableViewBgColor;

@end

NS_ASSUME_NONNULL_END
