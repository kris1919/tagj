//
//  TKDefinded.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#ifndef TKDefinded_h
#define TKDefinded_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define WS(weakSelf)  __weak __typeof(self) weakSelf = self

#define kIPhoneXSeries (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))
#define kTabBar_Height (kIPhoneXSeries ? (34.f + 49.f) : 49.f)
#define kNavigationBar_Height (kIPhoneXSeries ? (44.f + 44.f) : 64.f)
#endif /* TKDefinded_h */
