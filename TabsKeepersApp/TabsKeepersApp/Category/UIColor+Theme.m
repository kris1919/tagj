//
//  UIColor+Theme.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)alpha{
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:alpha];
}

+ (UIColor *)labelColorLevel51{
    return [UIColor colorWithR:51 G:51 B:51 A:1.f];
}

+ (UIColor *)labelColorLevel153{
    return [UIColor colorWithR:153 G:153 B:153 A:1.f];
}

+ (UIColor *)tableViewBgColor{
    return [UIColor colorWithR:239 G:239 B:245 A:1.f];
}

@end
