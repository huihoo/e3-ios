//
//  PhotoCollectionViewCell.h
//  phoneD
//
//  Created by scjh on 15/6/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoCollectionViewCell;

@protocol PhotoCollectionViewCellDelegate <NSObject>

- (void)photoCollectionViewCellDelegate:(PhotoCollectionViewCell *)objCell;

@end

@interface PhotoCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSDictionary *infoDic;

@property(nonatomic,strong) UIImageView *imageView;

@property(nonatomic,assign) id<PhotoCollectionViewCellDelegate> delegate;

@end
