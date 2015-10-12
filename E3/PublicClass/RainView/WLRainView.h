//
//  WLRainView.h
//  SCJHAPP_MealNew
//
//  Created by scjh on 14/12/25.
//  Copyright (c) 2014年 scjh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**  评价视星级视图*/

@interface WLRainView : UIView

/**images  为“满图，空图，半图” 或者 “满图，空图” */
- (instancetype)initWithFrame:(CGRect)frame
                withAllNumber:(int)allNumber
               withCurrNumber:(CGFloat)currNumber
                   withImages:(NSArray *)images
                  withBetween:(CGFloat)bet;

@property(nonatomic,assign)BOOL isChange;

@property(nonatomic,readonly) CGFloat rainNumber;

//重置点亮星的个数
@property(nonatomic,assign) NSInteger initNumber;

@end
