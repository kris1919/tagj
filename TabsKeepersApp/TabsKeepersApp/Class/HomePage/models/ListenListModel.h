//
//  ListenListModel.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListenDeviceModel : NSObject

@property (nonatomic ,copy)NSString *sbId;
@property (nonatomic ,copy)NSString *sbName;

@end

@interface ListenListModel : NSObject

@property (nonatomic ,copy)NSString *typeId;

@property (nonatomic ,copy)NSString *typeName;

@property (nonatomic ,strong)NSArray<ListenDeviceModel *> *shebei;

@end

NS_ASSUME_NONNULL_END
