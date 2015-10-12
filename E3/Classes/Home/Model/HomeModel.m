//
//  HomeModel.m
//  E3
//
//  Created by 王亮 on 15/8/18.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "HomeModel.h"

@interface HomeModel ()

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation HomeModel

- (instancetype)shareModel {
    
    static HomeModel *model = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
       
        model = [[HomeModel alloc] init];
    });
    return model;
}


- (void)startTimer:(NSTimer *)timer {
    
    self.timer = timer;
}

- (void)stopTimer {
    
}

@end
