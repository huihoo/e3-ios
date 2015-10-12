//
//  HomeBannerCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/8/18.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "HomeBannerCollectionViewCell.h"
#import "ImageCollectionViewCell.h"

@interface HomeBannerCollectionViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation HomeBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        [self UI];
    }
    return self;
}

- (void)UI {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.contentOffset = CGPointMake(1000 * CGRectGetWidth(collectionView.frame), 0);
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:WL_NIB(@"ImageCollectionViewCell") forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) * 0.75, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * 0.25)];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:pageControl];
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
}

- (void)setBannerList:(NSArray *)bannerList {
    
    _bannerList = bannerList;
    self.pageControl.numberOfPages = bannerList.count;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    if (self.bannerList.count > 0) {
        
        NSDictionary *dic = self.bannerList[indexPath.row % self.bannerList.count];
        NSURL *url = [NSURL URLWithString:dic[@"imagerpath"]];
        [cell.picImageView sd_setImageWithURL:url];
    }
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat moveX = scrollView.contentOffset.x;
    int index = moveX / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = index % self.bannerList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        [self.delegate proctocolCell:self withInfo:self.bannerList[self.pageControl.currentPage]];
    }
}

@end
