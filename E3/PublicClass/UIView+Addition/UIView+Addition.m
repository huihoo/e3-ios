//
//  UIView+Addition.m
//  SCJHAPP_Meal
//
//  Created by scjh on 14/11/18.
//  Copyright (c) 2014年 wangliang. All rights reserved.
//

#import "UIView+Addition.h"

FinishBlcok _block;
UIView *_carView;

@implementation UIView (Addition)


-(void) startAnimationWithCurve:(CGPoint)startPoint endPoint:(CGPoint) endPoint carView:(UIView *)carView finish:(FinishBlcok)finish
{
    
    CGRect frame = [[[UIApplication sharedApplication] keyWindow] bounds];
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    
    [bezierPath moveToPoint:startPoint];
    
    
    [bezierPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(fabs((endPoint.x - startPoint.x)) / 2 , CGRectGetWidth(frame) / 2 - (endPoint.y-startPoint.y) / 2)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 0.3;
    animation.path = bezierPath.CGPath;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(hiddenView) withObject:self afterDelay:0.4];
    
    _block = finish;
    _carView = carView;
}

/**动画结束后的方法*/
- (void)hiddenView
{
    self.hidden = YES;
    _block();
    [UIView animateWithDuration:0.1 animations:^{
        _carView.transform = CGAffineTransformMakeRotation(-M_1_PI);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _carView.transform = CGAffineTransformMakeRotation(M_1_PI);
        }completion:^(BOOL finished) {
            _carView.transform = CGAffineTransformMakeRotation(0);
        }];
    }];
}

+ (void)addLineView:(UIView *)view startY:(CGFloat)originY startX:(CGFloat)originX
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, view.frame.size.width - originX * 2, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
    [view addSubview:lineView];
}


@end
