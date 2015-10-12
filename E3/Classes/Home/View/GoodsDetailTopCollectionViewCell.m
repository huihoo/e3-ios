//
//  GoodsDetailTopCollectionViewCell.m
//  E3
//
//  Created by 王亮 on 15/7/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "GoodsDetailTopCollectionViewCell.h"
#import "ImageCollectionViewCell.h"
#import "PhotoBroswerVC.h"

#import "UILabel+WLCategory.h"

@interface GoodsDetailTopCollectionViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *orgImages;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *heartLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productOldLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSellLabel;
@property (weak, nonatomic) IBOutlet UILabel *productAreaLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHight;
@end

@implementation GoodsDetailTopCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self Data];
    [self UI];
}

- (void)Data {
    
    self.orgImages = [NSMutableArray array];
//    NSArray *imageName = @[@"u12.png",@"u42.png",@"u55.png",@"u68.png"];
//    for (int i = 0; i < 10; i ++) {
//        UIImage *image = [UIImage imageNamed:imageName[i % 4]];
//        [self.orgImages addObject:image];
//    }
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    for (NSString *str in infoDic[@"detail_small_pictures"]) {
        
        if ([str rangeOfString:@"detail"].length > 0) {
            
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",Base_Url,str];
            [self.orgImages addObject:urlStr];
        }
    }
    NSString *numText = [NSString stringWithFormat:@"%d/%ld",1,self.orgImages.count];
    self.numLabel.text = numText;
    [self.collectionView reloadData];
    
    NSDictionary *productDic = infoDic[@"product"];
    self.productNameLabel.text = productDic[@"product_name"];
    self.productPriceLabel.text = [NSString stringWithFormat:@"¥%0.2f",[productDic[@"product_price"][@"defaultPrice"] floatValue]];
    
    NSString *oldStr = [NSString stringWithFormat:@"%0.2f",[productDic[@"product_price"][@"listPrice"] floatValue]];
    self.productOldLabel.text = [NSString stringWithFormat:@"价格：%@",oldStr];
    [self.productOldLabel addLineMidColor:[UIColor grayColor] withStr:oldStr];
    self.productPaseLabel.text = @"快递 12.00元";
    self.productSellLabel.text = [NSString stringWithFormat:@"月销%@笔",productDic[@"product_order_num"]];
    self.productAreaLabel.text = @"成都";
}

- (void)UI {
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    CGSize size = self.collectionView.frame.size;
    size.width = IOS_IPHONE_WINDOW_WIDE;
    flowLayout.itemSize = size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView registerNib:WL_NIB(@"ImageCollectionViewCell") forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    self.numLabel.backgroundColor = [All_BackGroundColor colorWithAlphaComponent:0.5];
    self.numLabel.layer.cornerRadius = CGRectGetWidth(self.numLabel.frame) / 2;
    self.numLabel.clipsToBounds = YES;
    self.imageHight.constant =CGRectGetWidth(self.frame);
    self.heartLabel.text = @"加入\n心愿单";
    self.heartLabel.font = [UIFont boldSystemFontOfSize:8];
    self.productPriceLabel.textColor = All_BackGroundColor;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.orgImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"CollectionViewCell";
    if (indexPath.section == 0) {
        cellID = @"ImageCollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        ImageCollectionViewCell *theCell = (ImageCollectionViewCell *)cell;
        NSString *urlStr = self.orgImages[indexPath.row];
        [theCell.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSMutableArray *array = [NSMutableArray array];
    for (ImageCollectionViewCell *tCell in collectionView.visibleCells) {
        
        [array addObject:tCell.picImageView];
    }
    
    [PhotoBroswerVC show:(UIViewController *)self.delegate superView:self.collectionView type:PhotoBroswerVCTypeZoom index:indexPath.row photoModelBlock:^NSArray *{

        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:self.orgImages.count];
        for (NSUInteger i = 0; i< self.orgImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image_HD_U = self.orgImages[i];
            //源frame
            UIImageView *imageV = cell.picImageView;
            pbModel.sourceImageView = imageV;
            pbModel.sourceAllImageViews = array;
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    int index = offsetX / CGRectGetWidth(scrollView.frame) + 1;
    NSString *numText = [NSString stringWithFormat:@"%d/%ld",index,self.orgImages.count];
    self.numLabel.text = numText;
}

- (IBAction)buttonAction:(id)sender {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"product_id"] = self.infoDic[@"product"][@"product_id"];
    [[AppData shareData] userAddCollectWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"收藏成功"];
        }
    }];
}

@end
