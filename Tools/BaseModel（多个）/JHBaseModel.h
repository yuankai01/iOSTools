//
//  JHBaseModel.h
//  JHD_iOS
//
//  Created by Gao on 2019/1/19.
//  Copyright © 2019 JHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBaseModel : NSObject

- (id)initWithDictionary:(NSDictionary *)dic;

@end

#pragma mark - model转化为字典
@interface NSDictionary (Model)

+ (NSDictionary *)dictionaryFromObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
