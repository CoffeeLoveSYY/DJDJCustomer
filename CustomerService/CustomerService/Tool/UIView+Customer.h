//
//  UIView+Customer.h
//  ProbjectForChongqing
//
//  Created by 李杭玖 on 2022/10/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Customer)

+ (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight
                              view:(UIView *)view
                             frame:(CGRect)frame;

+ (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rigtTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight
                              view:(UIView *)view
                       borderWidth:(CGFloat)borderWidth
                       borderColor:(UIColor *)borderColor
                             frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
