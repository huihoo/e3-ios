//
//  CartViewController.m
//  E3
//
//  Created by colin liao on 7/27/15.
//  Copyright (c) 2015年 Huihoo. All rights reserved.
//

#import "CartViewController.h"
#import "CartCollectionReusableView.h"
#import "CartSupplierModel.h"
#import "CartProductModel.h"
#import "CartProductCollectionViewCell.h"
#import "UILabel+WLCategory.h"
#import "ProductListViewController.h"
#import "OrderCreateViewController.h"

@interface CartViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CellForSuperProtocol>
{
    NSInteger _allNum;
    CGFloat _allPrice;
    CGRect _collectFrame;
}
@property(nonatomic,strong)NSMutableArray *suppliersList;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)UIView *okBackView;
@property(nonatomic,strong)UIButton *okBtn;
@property(nonatomic,strong)UILabel *allPriceLabel;
@property(nonatomic,strong)UIView *noLoginBackView;

@end

@implementation CartViewController

- (NSMutableArray *)suppliersList {
    
    if (!_suppliersList) {
        
        _suppliersList = [NSMutableArray array];
    }
    return _suppliersList;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if ([User share].isLogin) {
        self.noLoginBackView.hidden = YES;
    }else {
        self.noLoginBackView.hidden = NO;
    }
}

- (void)noLogin {
    
    CGFloat wide = 0.8 * IOS_IPHONE_WINDOW_WIDE;
    CGFloat high = wide;
    UIView *loginBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wide, high)];
    loginBackView.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE / 2, (IOS_IPHONE_WINDOW_HIGH - 64 - 49)/ 2);
    loginBackView.backgroundColor = [UIColor clearColor];
    self.noLoginBackView = loginBackView;
    [self.view addSubview:loginBackView];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(loginBackView.frame), 30)];
    descLabel.text = @"您还没有登录哦！";
    descLabel.textAlignment = NSTextAlignmentCenter;
    [loginBackView addSubview:descLabel];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descLabel.frame) + 10, 100, 30)];
    loginBtn.backgroundColor = Color_Blue;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.center = CGPointMake(CGRectGetWidth(loginBackView.frame) / 2, loginBtn.center.y);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginBackView addSubview:loginBtn];
    
}

- (void)toLogin {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNavi animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"购物车";
    [self naviUI];
    [self initUI];
    [self noLogin];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @"1";
    [[AppData shareData] userShoppingGetCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        [self hiddenBtnView];
        if ([dic[@"code"] intValue] == 0) {
            
            if (dic[@"suppliers"] != nil) {
                
                [self.suppliersList removeAllObjects];
                
                for (NSDictionary *cellDic in dic[@"suppliers"]) {
                    
                    CartSupplierModel *model = [[CartSupplierModel alloc] init];
                    model.suppilerDic = cellDic;
                    model.isSelect = NO;
                    
                    for (NSDictionary *productDic in dic[@"group_cart_items"]) {
                        
                        if ([productDic[@"supplier_id"] isEqualToString:cellDic[@"supplier_id"]]) {
                            
                            NSMutableArray *array = [NSMutableArray array];
                            for (NSDictionary *proDic in productDic[@"products"]) {
                                
                                CartProductModel *productModel = [[CartProductModel alloc] init];
                                productModel.productDic = proDic;
                                productModel.isSelect = NO;
                                [array addObject:productModel];
                            }
                            
//                            for (int i = 0; i < 10; i ++) {
//                                
//                                CartProductModel *productModel = [[CartProductModel alloc] init];
//                                productModel.isSelect = NO;
//                                [array addObject:productModel];
//                            }
                            model.productList = [NSMutableArray arrayWithArray:array];
                            break;
                        }
                    }
                    
                    [self.suppliersList addObject:model];
                }
                [self.collectionView reloadData];
            }
        }
    }];

    
//    dic[@"product_id"] = @"10000-01";
//    dic[@"quantity"] = @"1";
//    dic[@"web_site_id"] = [User share].website_id;
//    dic[@"is_increase"] = @"false";
//    [[AppData shareData] userShoppingAddCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
    
//    dic[@"product_ids"] = @"10007-01,10012-02";
//    dic[@"web_site_id"] = [User share].website_id;
//    [[AppData shareData] userShoppingBatchAddCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10007-01";
//    dic[@"quantity"] = @"10";
//    dic[@"web_site_id"] = [User share].website_id;
//    [[AppData shareData] userShoppingChangeNumCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_ids"] = @"10012-02";
//    [[AppData shareData] userShoppingDeleteCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)naviUI {
    
    [self.leftBtn setTitle:@"清空" forState:UIControlStateNormal];
    
}

- (void)initUI {
    
    CGRect frame = CGRectMake(0, 0, IOS_IPHONE_WINDOW_WIDE, IOS_IPHONE_WINDOW_HIGH - 49);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(IOS_IPHONE_WINDOW_WIDE, 120);
    flowLayout.sectionInset = UIEdgeInsetsMake(0.5, 0, 10, 0);
    flowLayout.minimumLineSpacing = 0.5;
    flowLayout.headerReferenceSize = CGSizeMake(IOS_IPHONE_WINDOW_WIDE, 30);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame  collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = WLColor(212, 216, 214);
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"CartProductCollectionViewCell") forCellWithReuseIdentifier:@"CartProductCollectionViewCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    [collectionView registerNib:WL_NIB(@"CartCollectionReusableView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CartCollectionReusableView"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    deleteBtn.backgroundColor = Color_Blue;
    deleteBtn.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE - CGRectGetWidth(deleteBtn.frame) / 2, IOS_IPHONE_WINDOW_HIGH * 0.6);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    deleteBtn.layer.cornerRadius = CGRectGetWidth(deleteBtn.frame) / 2;
    deleteBtn.clipsToBounds = YES;
    [deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = deleteBtn;
    [self.view addSubview:deleteBtn];
    
    UIView *okBackView = [[UIView alloc] initWithFrame:CGRectMake(0, IOS_IPHONE_WINDOW_HIGH - 40 - 64 - 49, IOS_IPHONE_WINDOW_WIDE, 40)];
    okBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:okBackView];
    self.okBackView = okBackView;
    [self addViewForOKView:okBackView];
    
    _collectFrame = self.collectionView.frame;
    [self hiddenBtnView];
}

- (void)addViewForOKView:(UIView *)view {
    
    UIButton *allSelectBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    allSelectBtn.center = CGPointMake(allSelectBtn.center.x, CGRectGetHeight(view.frame) / 2);
    [allSelectBtn setImage:[UIImage imageNamed:@"选择-圈"] forState:UIControlStateNormal];
    [allSelectBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateSelected];
    [view addSubview:allSelectBtn];
    [allSelectBtn addTarget:self action:@selector(allSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    allSelectBtn.selected = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allSelectBtn.frame) + 2, 0, 50, CGRectGetHeight(view.frame))];
    label.text = @"全选";
    [view addSubview:label];
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(view.frame))];
    okBtn.backgroundColor = Color_Blue;
    okBtn.center = CGPointMake(CGRectGetWidth(view.frame) - CGRectGetWidth(okBtn.frame) / 2, okBtn.center.y);
    [view addSubview:okBtn];
    [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.okBtn = okBtn;
    
    UILabel *allPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, CGRectGetHeight(view.frame) / 2)];
    allPriceLabel.center = CGPointMake(CGRectGetWidth(view.frame) - CGRectGetWidth(okBtn.frame) - 20 - CGRectGetWidth(allPriceLabel.frame) / 2, allPriceLabel.center.y);
    [view addSubview:allPriceLabel];
    allPriceLabel.textAlignment = NSTextAlignmentRight;
    allPriceLabel.text = @"合计：";
    allPriceLabel.font = [UIFont systemFontOfSize:14];
    self.allPriceLabel = allPriceLabel;
    
    UILabel *decsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame) / 2, 150, CGRectGetHeight(view.frame) / 2)];
    decsLabel.text = @"不含运费";
    decsLabel.font = [UIFont systemFontOfSize:10];
    decsLabel.center = CGPointMake(allPriceLabel.center.x, decsLabel.center.y);
    decsLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:decsLabel];
}

- (void)allSelectBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
    
        _allNum = 0;
        _allPrice = 0.0;
        for (CartSupplierModel *model in self.suppliersList) {
            
            model.isSelect = YES;
            for (CartProductModel *productModel in model.productList) {
                
                productModel.isSelect = YES;
                NSInteger currNum = [productModel.productDic[@"quality"] integerValue];
                _allNum += currNum;
                _allPrice += [productModel.productDic[@"default_price"] floatValue] * currNum;

            }
        }
        [self showBtnView];
    }else {
        
        _allNum = 0;
        _allPrice = 0.0;
        [self hiddenBtnView];
        for (CartSupplierModel *model in self.suppliersList) {
            
            model.isSelect = NO;
            for (CartProductModel *productModel in model.productList) {
                
                productModel.isSelect = NO;
            }
        }
    }
     [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.suppliersList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    CartSupplierModel *model = self.suppliersList[section];
    return model.productList.count;
//    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"CollectionViewCell";
    cellID = @"CartProductCollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    CartProductCollectionViewCell *theCell = (CartProductCollectionViewCell *)cell;
    CartSupplierModel *model = self.suppliersList[indexPath.section];
    CartProductModel *productModel = model.productList[indexPath.row];
    theCell.productModel = productModel;
    theCell.section = indexPath.section;
    theCell.row = indexPath.row;
    theCell.delegate = self;
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString *headID = @"CollectionReusableView";
    headID = @"CartCollectionReusableView";
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headID forIndexPath:indexPath];
    reusableView.backgroundColor = [UIColor whiteColor];
    CartCollectionReusableView *headView = (CartCollectionReusableView *)reusableView;
    headView.model = self.suppliersList[indexPath.section];
    headView.section = indexPath.section;
    headView.delegate = self;
    return reusableView;
}

- (void)proctocolCell:(id)obj withInfo:(NSDictionary *)dic {
    
    if ([obj isKindOfClass:[CartCollectionReusableView class]]) {
        
        NSInteger type = [dic[@"type"] integerValue];
        if (type == 0) {
            BOOL state = [dic[@"state"] boolValue];
            CartCollectionReusableView *theCell = (CartCollectionReusableView *)obj;
            CartSupplierModel *model = self.suppliersList[theCell.section];
            for (CartProductModel *product in model.productList) {
                
                product.isSelect = state;
            }
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:theCell.section];
            [self.collectionView reloadSections:indexSet];
        }else if (type == 1) {
            
            ProductListViewController *productListVC = [[ProductListViewController alloc] init];
            productListVC.supplier_productDic = dic[@"info"];
            [self.navigationController pushViewController:productListVC animated:YES];
        }
        
    }else if ([obj isKindOfClass:[CartProductCollectionViewCell class]]) {
        
        CartProductCollectionViewCell *theCell = (CartProductCollectionViewCell *)obj;
        CartSupplierModel *model = self.suppliersList[theCell.section];
        model.productList[theCell.row] = theCell.productModel;
    }
    
    _allNum = 0;
    _allPrice = 0.0;
    for (CartSupplierModel *model in self.suppliersList) {
        
        for (CartProductModel *productModel in model.productList) {
            
            if(productModel.isSelect) {
                
                NSInteger currNum = [productModel.productDic[@"quality"] integerValue];
                _allNum += currNum;
                _allPrice += [productModel.productDic[@"default_price"] floatValue] * currNum;
            }
        }
    }
    
    if (_allNum == 0) {
        
        [self hiddenBtnView];
    }else {
        
        [self showBtnView];
    }
}

- (void)showBtnView {
    
    self.okBackView.hidden = NO;
    self.deleteBtn.hidden = NO;
    CGRect frame = _collectFrame;
    frame.size.height -= CGRectGetHeight(self.okBackView.frame);
    self.collectionView.frame = frame;
    NSString *okStr = [NSString stringWithFormat:@"结算（%ld）",_allNum];
    [self.okBtn setTitle:okStr forState:UIControlStateNormal];

    NSString *priceStr = [NSString stringWithFormat:@"¥%0.2f",_allPrice];
    NSString *allPriceStr = [NSString stringWithFormat:@"合计：%@",priceStr];
    self.allPriceLabel.text = allPriceStr;
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"text"] = priceStr;
    dic[@"font"] = self.allPriceLabel.font;
    dic[@"color"] = Color_Blue;
    [array addObject:dic];
    
    [self.allPriceLabel addMoreStates:array];
}

- (void)hiddenBtnView {
    
    self.okBackView.hidden = YES;
    self.deleteBtn.hidden = YES;
    self.collectionView.frame = _collectFrame;
    NSString *okStr = [NSString stringWithFormat:@"结算（%ld）",_allNum];
    [self.okBtn setTitle:okStr forState:UIControlStateNormal];
}

- (void)deleteBtnAction:(UIButton *)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    NSMutableArray *product_ids = [NSMutableArray array];
    for (CartSupplierModel *model in self.suppliersList) {
        
        for (CartProductModel *productModel in model.productList) {
            
            if(productModel.isSelect) {
                
                [product_ids addObject:productModel.productDic[@"product_id"]];
            }
        }
    }
    
    NSString *product_idStr = [product_ids componentsJoinedByString:@","];
    dic[@"product_ids"] = product_idStr;
    [[AppData shareData] userShoppingDeleteCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
    }];
}

- (void)okBtnAction:(UIButton *)sender {
    
    NSMutableArray *productDics = [NSMutableArray array];
    for (CartSupplierModel *model in self.suppliersList) {
        
        for (CartProductModel *productModel in model.productList) {
            
            if(productModel.isSelect) {
                
                NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithDictionary:productModel.productDic];
                selectDic[@"detail_image_url"] = productModel.productDic[@"product_small_image_url"];
//                NSString
                selectDic[@"product_V_id"] = productModel.productDic[@"product_id"];
                selectDic[@"select_num"] = productModel.productDic[@"quality"];
                [productDics addObject:selectDic];
            }
        }
    }

    
    OrderCreateViewController *orderCreateVC = [[OrderCreateViewController alloc] init];
    orderCreateVC.productDics = productDics;
    [self.navigationController pushViewController:orderCreateVC animated:YES];
}
@end
