//
//  CustomerUtils.m
//  Gomart
//
//  Created by xinhualong on 2017/11/6.
//  Copyright © 2017年 LeiXiao CQ. All rights reserved.
//

#import "CustomerUtils.h"

@implementation CustomerUtils

/*
 位置： 居左/右   局上/下
 大小： 宽   和  高
 
 */
+ (CGFloat)calculateWidthWithString:(NSString *)string height:(CGFloat)height font:(UIFont *)font {
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:NULL].size.width;
}

+ (CGFloat)calculateHeightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font {
    
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:NULL].size.height;
}

@end
