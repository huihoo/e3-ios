//
//  UIView+Addition.h
//  SCJHAPP_Meal
//
//  Created by scjh on 14/11/18.
//  Copyright (c) 2014年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FinishBlcok)();

@interface UIView (Addition)

/**添加购物车动画*/
-(void) startAnimationWithCurve:(CGPoint)startPoint endPoint:(CGPoint) endPoint carView:(UIView *)carView finish:(FinishBlcok)finish;
/**添加cell线*/
+ (void)addLineView:(UIView *)view startY:(CGFloat)originY startX:(CGFloat)originX;

@end
