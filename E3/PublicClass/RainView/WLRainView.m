//
//  WLRainView.m
//  SCJHAPP_MealNew
//
//  Created by scjh on 14/12/25.
//  Copyright (c) 2014年 scjh. All rights reserved.
//

#import "WLRainView.h"

@interface WLRainView ()
{
    CGFloat between;
    CGFloat imageViewWide;
    int imageNumber;
}
@property(nonatomic,assign) int allNumber;
@property(nonatomic,assign) CGFloat currNumber;
@property(nonatomic,strong) NSArray *images;

@property(nonatomic,strong) NSMutableArray *imageViews;

@end

@implementation WLRainView

- (NSMutableArray *)imageViews
{
    if (!_imageViews)
    {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (instancetype)initWithFrame:(CGRect)frame
                withAllNumber:(int)allNumber
               withCurrNumber:(CGFloat)currNumber
                   withImages:(NSArray *)images
                  withBetween:(CGFloat)bet
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        self.allNumber = allNumber;
        self.currNumber = currNumber;
        self.images = images;
        between = bet;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    
    imageViewWide = self.frame.size.height;
    
    CGFloat imageViewAllWide = self.frame.size.width - between * (self.allNumber - 1);
    
    if (imageViewAllWide / self.allNumber < imageViewWide)
    {
        imageViewWide = imageViewAllWide / self.allNumber;
    }
    
    imageNumber = self.images.count;
    
    if (self.currNumber < 0)
    {
        //可修改
        for (int i = 0; i < self.allNumber; i ++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageViewWide + between) * i, 0, imageViewWide, imageViewWide)];
            imageView.image = self.images[0];
            imageView.center = CGPointMake(imageView.center.x, self.frame.size.height / 2);
            [self addSubview:imageView];
            
            [self.imageViews addObject:imageView];
        }

    }else
    {
        //不可修改
        CGFloat isF =  self.currNumber - floorf(self.currNumber);
        for (int i = 0; i < self.allNumber; i ++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageViewWide + between) * i, 0, imageViewWide, imageViewWide)];
            
            if (isF == 0)
            {
                if(i < self.currNumber)
                {
                    imageView.image = self.images[0];
                }else
                {
                    imageView.image = self.images[imageNumber - 1];
                }
            }else
            {
                if(i < floorf(self.currNumber))
                {
                    imageView.image = self.images[0];
                }else if (i == floorf(self.currNumber))
                {
                    imageView.image = self.images[imageNumber - 1];
                }else
                {
                    if(imageNumber - 2 == 0)
                    {
                        imageView.image = self.images[imageNumber - 1];
                    }else
                    {
                        imageView.image = self.images[imageNumber - 2];
                    }
                }
            }
            imageView.center = CGPointMake(imageView.center.x, self.frame.size.height / 2);
            
            [self addSubview:imageView];
            [self.imageViews addObject:imageView];
        }
    }
}

- (void)setIsChange:(BOOL)isChange
{
    if (isChange)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self addGestureRecognizer:tapGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:panGesture];
    }
    _isChange = isChange;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point = [tapGesture locationInView:self];
    int number = point.x / (between + imageViewWide);
    BOOL isUp = point.x - (between + imageViewWide) * number > imageViewWide / 2 ? YES : NO;
    for (int i = 0; i < self.imageViews.count; i ++)
    {
        UIImageView *imageView = self.imageViews[i];
        if (i < number)
        {
            imageView.image = self.images[0];
        }else if (i > number )
        {
            if(imageNumber - 2 == 0)
            {
                imageView.image = self.images[imageNumber - 1];
            }else
            {
                imageView.image = self.images[imageNumber - 2];
            }
        }else
        {
            if (imageView.image == self.images[0])
            {
                //点亮
                if (isUp)
                {
                    imageView.image = self.images[imageNumber - 1];
                }else
                {
                    imageView.image = self.images[imageNumber - 1];
                }
                
            }else if (imageView.image == self.images[imageNumber - 1]  && imageNumber == 3)
            {
                //半亮 或者 不亮
                if (isUp)
                {
                    imageView.image = self.images[0];
                }else
                {
                    if(imageNumber - 2 == 0)
                    {
                        imageView.image = self.images[imageNumber - 1];
                    }else
                    {
                        imageView.image = self.images[imageNumber - 2];
                    }
                }
                
            }else
            {
                //不亮
                if (isUp)
                {
                    imageView.image = self.images[0];
                }else
                {
                    if (imageNumber == 2)
                    {
                        imageView.image = self.images[0];
                    }else
                    {
                        imageView.image = self.images[imageNumber - 1];
                    }
                }
            }
        }
    }
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self];
    int number = point.x / (between + imageViewWide);
    BOOL isUp = point.x - (between + imageViewWide) * number > imageViewWide / 2 ? YES : NO;
    for (int i = 0; i < self.imageViews.count; i ++)
    {
        UIImageView *imageView = self.imageViews[i];
        if (i < number)
        {
            imageView.image = self.images[0];
        }else if (i > number )
        {
            if(imageNumber - 2 == 0)
            {
                //如果只有两种情况
                imageView.image = self.images[imageNumber - 1];
            }else
            {
                //如果三种情况
                imageView.image = self.images[imageNumber - 2];
            }
        }else
        {
            if (isUp)
            {
                imageView.image = self.images[0];
            }else
            {
                imageView.image = self.images[imageNumber - 1];
            }
        }
    }
}


- (CGFloat)rainNumber
{
    
    CGFloat rainNum = 0.0;
    
    for (int i = 0; i < self.imageViews.count; i ++)
    {
        UIImageView *imageView = self.imageViews[i];
        if (imageNumber == 2)
        {
            if (imageView.image == self.images[imageNumber - 1])
            {
                rainNum = i;
                break;
            }
            rainNum = i + 1;
        }else
        {
            if (imageView.image == self.images[imageNumber - 1])
            {
                rainNum = i + 0.5;
                break;
            }else if (imageView.image == self.images[imageNumber - 2])
            {
                rainNum = i;
                break;
            }
            rainNum = i + 1;
        }
    }
    
    return rainNum;
}


- (void)setInitNumber:(NSInteger)initNumber {
    
    for (int i = 0; i < self.imageViews.count; i ++) {
        
        UIImageView *imageView = self.imageViews[i];
        if (i < initNumber) {
            
            imageView.image = self.images[0];
        }else {
            
            if(imageNumber - 2 == 0)
            {
                //如果只有两种情况
                imageView.image = self.images[imageNumber - 1];
            }else
            {
                //如果三种情况
                imageView.image = self.images[imageNumber - 2];
            }
        }
    }
}

@end
