//
//  UIColor+Customer.h
//  DDSceneMonitor
//
//  Created by danfan on 2019/12/9.
//  Copyright © 2019 danfan. All rights reserved.
//  颜色

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Customer)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
