//
//  NSDictionary+extension.h
//  westGangProject
//
//  Created by helinjin on 16/3/23.
//  Copyright © 2016年 helinjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Customer)

- (id)dicValueforKey : (NSString *)key;

- (BOOL)dicBOOLForKey:(NSString *)key;

- (NSString *)dicStringForKey:(NSString *)key;

- (CGFloat)dicFloatForKey:(NSString *)key;

- (NSArray *)dicArrayForKey:(NSString *)key;

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end
