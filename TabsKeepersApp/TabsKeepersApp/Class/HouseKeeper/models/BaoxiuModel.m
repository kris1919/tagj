//
//  BaoxiuModel.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "BaoxiuModel.h"

@implementation BaoxiuModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"bxid" : @"id"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSInteger ztCode = self.zt.integerValue;
    if (ztCode == 1) {
        self.ztStr = @"待处理";
    }else if (ztCode == 2){
        self.ztStr = @"已处理";
    }else if (ztCode == 3){
        self.ztStr = @"已撤销";
    }else{
        self.ztStr = @"";
    }
    NSInteger pjCode = self.pjZt.integerValue;
    if (pjCode == 1) {
        self.pjZtStr = @"未评价";
    }else if (pjCode == 2){
        self.pjZtStr = @"已评价";
    }else{
        self.pjZtStr = @"";
    }
    return YES;
}

@end
