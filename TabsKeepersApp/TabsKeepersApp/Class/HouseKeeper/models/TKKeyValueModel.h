//
//  TKKeyValueModel.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKKeyValueModel : NSObject
@property (nonatomic ,copy)NSString *key;
@property (nonatomic ,copy)NSString *value;
- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
