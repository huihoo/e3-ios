//
//  SelectSizeView.m
//  E3
//
//  Created by 王亮 on 15/8/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "SelectSizeView.h"
#import "SelectInfoCollectionViewCell.h"
#import "SelectSizeCollectionViewCell.h"
#import "SelectNumCollectionViewCell.h"


@interface SelectSizeView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CellForSuperProtocol>
{
    NSInteger _num;
}
@property(nonatomic,strong)UIView *contView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSDictionary *featureDic;
@property(nonatomic,strong)NSMutableDictionary *selectDic;

@end

@implementation SelectSizeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _num = 1;
        [self UI];
    }
    return self;
}

- (NSMutableDictionary *)selectDic {
    
    if (!_selectDic) {
        
        _selectDic = [NSMutableDictionary dictionary];
    }
    return _selectDic;
}

- (void)UI {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self addSubview:backView];
    
    CGRect frame1 = [UIApplication sharedApplication].keyWindow.bounds;
    frame1.origin.y = 100;
    frame1.size.height -= 100;

    UIView *contentView = [[UIView alloc] initWithFrame:frame1];
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
    self.contView = contentView;
    
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
    frame.size.height -= 100 + 49;
    frame.origin.y = 0;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0.5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"SelectInfoCollectionViewCell") forCellWithReuseIdentifier:@"SelectInfoCollectionViewCell"];
    [collectionView registerClass:[SelectSizeCollectionViewCell class] forCellWithReuseIdentifier:@"SelectSizeCollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"SelectNumCollectionViewCell") forCellWithReuseIdentifier:@"SelectNumCollectionViewCell"];
    [contentView addSubview:collectionView];
    self.collectionView = collectionView;

    CGFloat wide = CGRectGetWidth(collectionView.frame) / 2;
    CGFloat high = 49;
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame), wide,high)];
    buyBtn.backgroundColor = Color_Blue;
    buyBtn.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE -wide / 2, buyBtn.center.y);
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:buyBtn];
    [buyBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cartBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame), wide, high)];
    cartBtn.backgroundColor = WLColor(86, 242, 149);
    cartBtn.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE - wide/ 2 * 3, buyBtn.center.y);
    [cartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [cartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:cartBtn];
    [cartBtn addTarget:self action:@selector(cartBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.contView.center = CGPointMake(self.contView.center.x, CGRectGetHeight(self.frame) +CGRectGetHeight(self.contView.frame) * 0.5);
    
    frame.size.height -= 20;
    frame.origin.y = 20;
    UIView *contentBackView = [[UIView alloc] initWithFrame:frame];
    contentBackView.backgroundColor = [UIColor whiteColor];
    [contentView insertSubview:contentBackView belowSubview:collectionView];


}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.infoDic) {
        
        return 10;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"CollectionViewCell";
    if (indexPath.row == 0) {
        
        cellID = @"SelectInfoCollectionViewCell";
    }else if(indexPath.row <= [self.featureDic allKeys].count) {
        
        cellID = @"SelectSizeCollectionViewCell";
    }else if(indexPath.row == [self.featureDic allKeys].count + 1) {
        
        cellID = @"SelectNumCollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(indexPath.row == 0) {
        
        SelectInfoCollectionViewCell *theCell = (SelectInfoCollectionViewCell *)cell;
        theCell.infoDic = self.infoDic[@"product"];
        theCell.delegate = self;
    }else if (indexPath.row <= [self.featureDic allKeys].count) {
        
        NSString *key = self.featureDic.allKeys[indexPath.row - 1];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.featureDic];
        dic[@"key"] = key;
        SelectSizeCollectionViewCell *theCell = (SelectSizeCollectionViewCell *)cell;
        theCell.infoDic = dic;
    }else if (indexPath.row == [self.featureDic allKeys].count + 1 ) {
        
        SelectNumCollectionViewCell *theCell = (SelectNumCollectionViewCell *)cell;
        theCell.delegate = self;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeZero;
    if (indexPath.row == 0) {
        size.height = 120;
    }else if (indexPath.row <= [self.featureDic allKeys].count) {
        
        size.height = 130;
    }else if(indexPath.row == [self.featureDic allKeys].count + 1){
        size.height = 50;
    }
    
    size.width = IOS_IPHONE_WINDOW_WIDE;
    return size;
}

- (void)proctocolCell:(id)obj withInfo:(NSDictionary *)dic {
    
    NSString *state = dic[@"status"];
    if ([state isEqualToString:@"exit"]) {
        [self dismissContent];
    }else if ([state isEqualToString:@"select"]){
     
        [self selectProductDic:dic];
    }else if ([obj isKindOfClass:[SelectNumCollectionViewCell class]]) {
        
        _num = [dic[@"num"] integerValue];
    }
}

- (void)selectProductDic:(NSDictionary *)dic {
    
    NSArray *products = self.infoDic[@"variant"];
    
    NSMutableArray *featureStrArray = [NSMutableArray array];
    for (int i = 0; i < products.count; i ++) {
        
        NSDictionary *productDic = products[i];
        NSDictionary *featureDic = productDic[@"product_feature"];
        NSArray *keyArray = featureDic.allKeys;
        NSMutableString *featureStr = [NSMutableString string];
        for (int j = 0 ; j < keyArray.count; j ++) {
            
            NSString *key = keyArray[j];
            [featureStr appendString:key];
            [featureStr appendString:@":"];
            [featureStr appendString:featureDic[key][0][@"product_feature_id"]];
            [featureStr appendString:@","];
        }
        [featureStrArray addObject:featureStr];
    }
    
    NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [selectDic removeObjectForKey:@"status"];
    
    NSMutableString *selectStr = [NSMutableString string];
    NSArray *keys = selectDic.allKeys;
    for (int i = 0; i < keys.count; i ++) {
        
        NSString *key = keys[i];
        [selectStr appendString:key];
        [selectStr appendString:@":"];
        [selectStr appendString:selectDic[key][@"product_feature_id"]];
        [selectStr appendString:@","];
    }
    

    
    for (int i = 0; i < featureStrArray.count; i ++) {
        
        NSString *str = featureStrArray[i];
        if ([str isEqual:selectStr]) {
            
            [self.selectDic addEntriesFromDictionary:products[i]];
            break;
        }
    }
    self.selectDic[@"detail_image_url"] = self.infoDic[@"product"][@"detail_image_url"];
    self.selectDic[@"product_V_id"] = self.infoDic[@"product"][@"product_id"];
    self.selectDic[@"default_price"] = self.infoDic[@"product"][@"product_price"][@"defaultPrice"];
    
}

- (void)showContent {
    
    
    [self.collectionView reloadData];
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.contView.center = CGPointMake(self.contView.center.x, CGRectGetHeight(self.frame)  - CGRectGetHeight(self.contView.frame) * 0.5);
    }];
}

- (void)dismissContent {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.contView.center = CGPointMake(self.contView.center.x, CGRectGetHeight(self.frame)  + CGRectGetHeight(self.contView.frame) * 0.5);
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}


- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.featureDic = [infoDic[@"product"][@"product_feature"] isKindOfClass:[NSNull class]] ? @{} : infoDic[@"product"][@"product_feature"];
    [self.collectionView reloadData];
}

- (void)cartBtnAction:(UIButton *)sender {
    
    NSLog(@"添加购物车");
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        
        if (self.selectDic.allKeys.count == 0) {
            
            [self.selectDic addEntriesFromDictionary:self.infoDic[@"product"]];
            self.selectDic[@"detail_image_url"] = self.infoDic[@"product"][@"detail_image_url"];
            self.selectDic[@"product_V_id"] = self.infoDic[@"product"][@"product_id"];
            self.selectDic[@"default_price"] = self.infoDic[@"product"][@"product_price"][@"defaultPrice"];
        }
        self.selectDic[@"select_num"] = @(_num);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.selectDic];
        dic[@"wl_status"] = @"addCart";
        [self.delegate proctocolCell:self withInfo:dic];
    }
}

- (void)buyBtnAction:(UIButton *)sender {
    
    NSLog(@"购买");
    if ([self.delegate respondsToSelector:@selector(proctocolCell:withInfo:)]) {
        if (self.selectDic.allKeys.count == 0) {
            
            [self.selectDic addEntriesFromDictionary:self.infoDic[@"product"]];
            self.selectDic[@"detail_image_url"] = self.infoDic[@"product"][@"detail_image_url"];
            self.selectDic[@"product_V_id"] = self.infoDic[@"product"][@"product_id"];
            self.selectDic[@"default_price"] = self.infoDic[@"product"][@"product_price"][@"defaultPrice"];
        }
        self.selectDic[@"select_num"] = @(_num);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.selectDic];
        dic[@"wl_status"] = @"buy";
        
        [self.delegate proctocolCell:self withInfo:dic];
    }

}

@end
