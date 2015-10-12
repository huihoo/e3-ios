//
//  PhotoCollectionViewCell.m
//  phoneD
//
//  Created by scjh on 15/6/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

static NSString *photoAddDefaultStr = @"grzx_11";
static NSString *photoDelDefaultStr = @"grzx_03.png";

@interface PhotoCollectionViewCell ()

@property(nonatomic,strong)UIButton *deleteBtn;

@end

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        [self UI];
    }
    return self;
}

- (void)UI {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
    self.imageView = imageView;
    self.imageView.image = [UIImage imageNamed:photoAddDefaultStr];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    deleteBtn.center = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetWidth(deleteBtn.frame) / 2,  CGRectGetHeight(deleteBtn.frame) / 2);
    [deleteBtn setImage:[UIImage imageNamed:photoDelDefaultStr] forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    deleteBtn.hidden = YES;
    [deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = deleteBtn;

}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    if ([infoDic[@"image"] isKindOfClass:[UIImage class]]) {
        
        self.imageView.image = infoDic[@"image"];
        self.deleteBtn.hidden = NO;
    }else if([infoDic[@"image"] isKindOfClass:[NSString class]] && ![infoDic[@"image"] isEqual:@""]){
        
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kUrl,infoDic[@"image"]]];
//        [self.imageView sd_setImageWithURL:url];
    }
    else{
        self.imageView.image = [UIImage imageNamed:photoAddDefaultStr];
        self.deleteBtn.hidden = YES;
    }
}

- (void)deleteBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(photoCollectionViewCellDelegate:)]) {
        
        [self.delegate photoCollectionViewCellDelegate:self];
    }
}

@end
