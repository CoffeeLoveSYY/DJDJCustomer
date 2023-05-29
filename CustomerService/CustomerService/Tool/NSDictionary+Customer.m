//
//  NSDictionary+Customer.m
//  westGangProject
//
//  Created by helinjin on 16/3/23.
//  Copyright © 2016年 helinjin. All rights reserved.
//

#import "NSDictionary+Customer.h"

@implementation NSDictionary (Customer)

- (id)dicValueforKey : (NSString *)key
{
    id value = [self objectForKey:key];
    if([value isKindOfClass:[NSNull class]] || !value)
    {
        return nil;
    }
    else
    {
        return value;
    }
}

- (BOOL)dicBOOLForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if([value isKindOfClass:[NSNull class]] || !value)
    {
        return false;
    }
    else
    {
        NSString *boolStr = [NSString stringWithFormat:@"%@",value];
        if ([boolStr isEqualToString:@"0"]) {
            return false;
        }else {
            return true;
        }
    }
}

- (NSString *)dicStringForKey:(NSString *)key {
    id value = [self objectForKey:key];
    if([value isKindOfClass:[NSNull class]] || !value || value==nil || [value isEqual:[NSNull null]])
    {
        return @"";
    }
    else
    {
        return [NSString stringWithFormat:@"%@",value];
    }
}

- (CGFloat)dicFloatForKey:(NSString *)key {
    NSString *valueString = [self dicStringForKey:key];
    if (valueString.length) {
        return [valueString floatValue];
    }else {
        return 0.0;
    }
}

- (NSArray *)dicArrayForKey:(NSString *)key {
    
    id value = [self objectForKey:key];
    if([value isKindOfClass:[NSNull class]] || !value)
    {
        return @[];
    }
    else
    {
        return value;
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

@end
