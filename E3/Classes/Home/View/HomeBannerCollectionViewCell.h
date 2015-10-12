//
//  HomeBannerCollectionViewCell.h
//  E3
//
//  Created by 王亮 on 15/8/18.
//  Copyright (c) 2015年 Huihoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellForSuperProtocol.h"

@interface HomeBannerCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSArray *bannerList;
@property(nonatomic,assign)id<CellForSuperProtocol> delegate;

@end
