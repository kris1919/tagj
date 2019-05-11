//
//  TKUtils.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKUtils : NSObject

+ (__kindof UIViewController *)viewControllerWithStory:(NSString *)story storyId:(NSString *)storyId;

+ (UIView *)nibWithNibName:(NSString *)nibName;

@end

NS_ASSUME_NONNULL_END
