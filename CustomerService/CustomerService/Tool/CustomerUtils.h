//
//  CustomerUtils.h
//  Gomart
//
//  Created by xinhualong on 2017/11/6.
//  Copyright © 2017年 LeiXiao CQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface CustomerUtils : NSObject

/**
 *  计算文字占用宽度
 *
 *  @param string 文字
 *  @param height 固定高度
 *  @param font   文字大小
 *
 *  @return 宽度
 */
+ (CGFloat)calculateWidthWithString:(NSString *)string height:(CGFloat)height font:(UIFont *)font;

/**
 *  计算文字占用高度
 *
 *  @param string 文字
 *  @param width  固定宽度
 *  @param font   字体大小
 *
 *  @return 高度
 */
+ (CGFloat)calculateHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font;

@end
