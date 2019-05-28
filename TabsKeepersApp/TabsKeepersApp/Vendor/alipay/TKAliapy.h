//
//  TKAliapy.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKAliapy : NSObject

+ (void)alipayWithSign:(NSString *)signedString callBack:(void(^)(NSDictionary *resultDic))callBack;

@end

NS_ASSUME_NONNULL_END
