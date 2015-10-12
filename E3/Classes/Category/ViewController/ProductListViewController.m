//
//  ProductListViewController.m
//  E3
//
//  Created by 王亮 on 15/8/24.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "ProductListViewController.h"
#import "NSString+Addition.h"
#import "AutoWideButton.h"
#import "ProductCollectionViewCell.h"
#import "WaterFallFlowCollectionViewFlowLayout.h"
#import "GoodsDetailViewController.h"

@interface ProductListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger pageNum;
}

@property(nonatomic,strong)NSMutableArray *productList;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)WaterFallFlowCollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)AutoWideButton *lastBtn;

@end

@implementation ProductListViewController

- (NSMutableArray *)productList {
    
    if (!_productList) {
        _productList = [NSMutableArray array];
    }
    return _productList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageNum = 1;
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)obtaionData:(NSDictionary *)dic {
    
    [[AppData shareData] productListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [self.productList addObjectsFromArray:dic[@"product_list"]];
            self.collectionView.collectionViewLayout = [self refreshData1];
            if (pageNum == 1) {
                [self.collectionView headerEndRefreshing];
            }else {
                [self.collectionView footerEndRefreshing];
            }
            
            [self.collectionView reloadData];
        }
    }];
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    
    _infoDic = infoDic;
    self.title = infoDic[@"category_name"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"category_id"] = infoDic[@"product_category_id"];
    dic[@"category_id"] = @"2789";
    dic[@"page_size"] = @"12";
    pageNum = 1;
    dic[@"page_num"] = [NSString stringWithFormat:@"%ld",pageNum];
    dic[@"status"] = @"normal";
    [self obtaionData:dic];
}

- (void)obationSupplierProduct:(NSDictionary *)dic {
    
    [[AppData shareData] productSupplierProductWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [self.productList addObjectsFromArray:dic[@"product_list"]];
            self.collectionView.collectionViewLayout = [self refreshData1];
            if (pageNum == 1) {
                [self.collectionView headerEndRefreshing];
            }else {
                [self.collectionView footerEndRefreshing];
            }
            
            [self.collectionView reloadData];
        }
    }];
}

- (void)setSupplier_productDic:(NSDictionary *)supplier_productDic {
    
    _supplier_productDic = supplier_productDic;
    self.title = supplier_productDic[@"supplier_name"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"party_id"] = supplier_productDic[@"supplier_id"];
    pageNum = 1;
    dic[@"page_num"] = [NSString stringWithFormat:@"%ld",pageNum];
    dic[@"page_size"] = @"12";
    [self obationSupplierProduct:dic];
}

- (void)initViews {
    
    NSArray *array = @[@"按销量  ",@"按价格  "];
    int num = (int)array.count;
    CGFloat wide = CGRectGetWidth(self.view.frame) / num;
    
    for (int i = 0; i < num; i ++) {
    
        CGFloat imageWide = 10;
        UIImage *btnImage = [UIImage imageNamed:@"iconfont-xiangxiajiantou (1)"];
        UIImage *btnImageD = [UIImage imageNamed:@"iconfont-xiangxiajiantou"];
        
        AutoWideButton *btn = [[AutoWideButton alloc] initWithFrame:CGRectMake( wide * i, 0, wide , 30)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.backgroundColor = Color_Blue;
        CGRect frame = btn.frame;
        frame.size = [array[i] sizeWithFont:btn.titleLabel.font maxSize:CGSizeMake(wide,MAXFLOAT)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWide, 0, imageWide)];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, frame.size.width, 0, -frame.size.width)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width + imageWide + 40, 0, imageWide, imageWide * btnImage.size.height / btnImage.size.width)];
        imageView.center = CGPointMake(imageView.center.x , CGRectGetHeight(btn.frame) / 2);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addSubview:imageView];
        btn.btnDic = @{@"imageView":imageView};
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            btn.selected = YES;
            imageView.image = btnImage;
            self.lastBtn = btn;
        }else {
            btn.selected = NO;
            imageView.image = btnImageD;
        }
        
    }
    
    CGFloat originY =  30;
    CGRect collectionFrame = CGRectMake(0, originY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - originY - 64);
    
    
    NSMutableArray *productList = [[NSMutableArray alloc] init];
    
    NSArray *imageName = @[@"u12.png",@"u42.png",@"u55.png",@"u68.png"];
    
    for (int i = 0; i < 100; i ++) {
        
        int index =  arc4random() % 4 ;
        
        UIImage *image =[UIImage imageNamed:imageName[index]];
        [productList addObject:image];
    }



    
    WaterFallFlowCollectionViewFlowLayout *flowLayout = [self refreshData];
   
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    flowLayout.itemSize = CGSizeMake((IOS_IPHONE_WINDOW_WIDE - 30 ) / 2, 300);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionFrame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = Color_Back_Gray;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCollectionViewCell"];
    [collectionView addHeaderWithTarget:self action:@selector(refreshListData)];
    [collectionView addFooterWithTarget:self action:@selector(addMoreListData)];
    self.collectionView = collectionView;
    
}

- (void)refreshListData {
    
    pageNum = 1;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.productList removeAllObjects];
    if (self.infoDic) {
        
        //    dic[@"category_id"] = infoDic[@"product_category_id"];
        dic[@"category_id"] = @"2789";
        dic[@"page_size"] = @"12";
        dic[@"page_num"] = [NSString stringWithFormat:@"%ld",pageNum];
        dic[@"status"] = @"normal";
        [self obtaionData:dic];
    }else if(self.supplier_productDic) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"party_id"] = self.supplier_productDic[@"supplier_id"];
        dic[@"page_num"] = [NSString stringWithFormat:@"%ld",pageNum];
        dic[@"page_size"] = @"12";
        [self obationSupplierProduct:dic];
    }
}

- (void)addMoreListData {
    
    pageNum ++;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.infoDic) {
        
        //    dic[@"category_id"] = infoDic[@"product_category_id"];
        dic[@"category_id"] = @"2789";
        dic[@"page_size"] = @"12";
        dic[@"page_num"] = [NSString stringWithFormat:@"%ld",pageNum];
        dic[@"status"] = @"normal";
        [self obtaionData:dic];
    }else if(self.supplier_productDic) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"party_id"] = self.supplier_productDic[@"supplier_id"];
        dic[@"page_num"] = [NSString stringWithFormat:@"%ld",pageNum];
        dic[@"page_size"] = @"12";
        [self obationSupplierProduct:dic];
    }
}

- (WaterFallFlowCollectionViewFlowLayout *)refreshData {
    
    NSMutableArray *twoItemArray = [NSMutableArray array];
    for (int i = 0 ; i < 6; i ++) {
        
        Item *item = [[Item alloc] init];
        item.width = (CGRectGetWidth(self.view.frame) - 30) / 2;
        item.height = item.width + 60;
        [twoItemArray addObject:item];
    }
    
    NSMutableArray* flowLayoutArray = [NSMutableArray array];
    
    SectionItem* item = [[SectionItem alloc] init];
    item.section = 0;
    item.headerType = SupplementType_Default;
    item.footerType = SupplementType_Default;
    
    item.listAmount = 2;
    item.minimumInteritemSpacing = 1;
    item.minimumLineSpacing = 1;
    item.itemArray = twoItemArray;
    item.footerType = SupplementType_ALL;
    item.footerSize = CGSizeMake(CGRectGetWidth(self.view.frame), 0.5);
    item.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    [flowLayoutArray addObject:item];
    
    WaterFallFlowCollectionViewFlowLayout *flowLayout = [[WaterFallFlowCollectionViewFlowLayout alloc] initWithSectionArray:flowLayoutArray];
    self.flowLayout = flowLayout;
    return flowLayout;
}

- (WaterFallFlowCollectionViewFlowLayout *)refreshData1 {
    
    NSMutableArray *twoItemArray = [NSMutableArray array];
    for (int i = 0 ; i < self.productList.count; i ++) {
        
        Item *item = [[Item alloc] init];
        item.width = (CGRectGetWidth(self.view.frame) - 30) / 2;
        NSString *descStr = [self.productList[i][@"product_name"] isKindOfClass:[NSNull class]] ? @"" : self.productList[i][@"product_name"];
        CGSize size = [descStr sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(item.width, CGFLOAT_MAX)];
        item.height = item.width + 40 + size.height;
        [twoItemArray addObject:item];
    }
    
    NSMutableArray* flowLayoutArray = [NSMutableArray array];
    
    SectionItem* item = [[SectionItem alloc] init];
    item.section = 0;
    item.headerType = SupplementType_Default;
    item.footerType = SupplementType_Default;
    
    item.listAmount = 2;
    item.minimumInteritemSpacing = 10;
    item.minimumLineSpacing = 10;
    item.itemArray = twoItemArray;
    item.footerType = SupplementType_ALL;
    item.footerSize = CGSizeMake(CGRectGetWidth(self.view.frame), 0.5);
    item.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    [flowLayoutArray addObject:item];
    
    WaterFallFlowCollectionViewFlowLayout *flowLayout = [[WaterFallFlowCollectionViewFlowLayout alloc] initWithSectionArray:flowLayoutArray];
    self.flowLayout = flowLayout;
    return flowLayout;
}

- (void)btnAction:(AutoWideButton *)sender {
  
    UIImage *btnImage = [UIImage imageNamed:@"iconfont-xiangxiajiantou (1)"];
    UIImage *btnImageD = [UIImage imageNamed:@"iconfont-xiangxiajiantou"];
    
    if (self.lastBtn == sender) {
        
        UIImageView *imageView = sender.btnDic[@"imageView"];
        
        if (imageView.highlighted == NO) {
         
            [UIView animateWithDuration:0.2 animations:^{
                imageView.highlighted = YES;
                imageView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }else {
            
            [UIView animateWithDuration:0.2 animations:^{
                imageView.highlighted = NO;
                imageView.transform = CGAffineTransformMakeRotation(0);
            }];
        }
        
        
    }else {
        
        UIImageView *lastImageView = self.lastBtn.btnDic[@"imageView"];
        lastImageView.image = btnImageD;
        self.lastBtn.selected = NO;
        
        UIImageView *imageView = sender.btnDic[@"imageView"];
        imageView.image = btnImage;
        sender.selected = YES;
//        
//        if (sender.selected == YES) {
//            
//            sender.selected = NO;
//            
//        }else {
//            
//            sender.selected = YES;
//            [UIView animateWithDuration:0.2 animations:^{
//                
//                imageView.transform = CGAffineTransformMakeRotation(0);
//            }];
//        }
        self.lastBtn = sender;
    }
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.flowLayout.sectionItemArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    SectionItem* item = self.flowLayout.sectionItemArray[section];
    return item.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"CollectionViewCell";
    if (indexPath.section == 0) {
        
        cellID = @"ProductCollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];    
    if (indexPath.section == 0 && self.productList.count > 0) {
        
        ProductCollectionViewCell *theCell = (ProductCollectionViewCell *)cell;
        theCell.infoDic = self.productList[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsDetailViewController *goodsVC = [[GoodsDetailViewController alloc] init];
    goodsVC.productId = self.productList[indexPath.row][@"product_id"];
    [self.navigationController pushViewController:goodsVC animated:YES];
    
}

@end
