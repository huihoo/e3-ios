//
//  DetailSameCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/19.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "DetailSameCollectionViewCell.h"
#import "GoodsCollectionViewCell.h"

@interface DetailSameCollectionViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation DetailSameCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self UI];
    }
    return self;
}

- (void)UI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
    label.text = @"相似宝贝";
    label.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:label];
    
    CGRect frame = self.frame;
    frame.size.height -= CGRectGetMaxY(label.frame);
    frame.origin.y = CGRectGetMaxY(label.frame);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(90, 140);
    flowLayout.minimumLineSpacing = 40;
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"GoodsCollectionViewCell") forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    collectionView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"CollectionViewCell";
    if (indexPath.section == 0) {
        cellID = @"GoodsCollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID  forIndexPath:indexPath];
    return cell;
}

@end
