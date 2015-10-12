//
//  GoodsDetailViewController.m
//  E3
//
//  Created by 王亮 on 15/7/28.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "WaterFallFlowCollectionViewFlowLayout.h"
#import "GoodsDetailTopCollectionViewCell.h"
#import "DetailDescCollectionViewCell.h"
#import "DetialListCollectionViewCell.h"

#import "DetaiIntroduceCollectionViewCell.h"
#import "SelectProductCollectionViewCell.h"
#import "DetailRianCollectionViewCell.h"
#import "ProductSuplierCollectionViewCell.h"
#import "DetailSameCollectionViewCell.h"
#import "DetailMoreCollectionViewCell.h"
#import "SelectSizeView.h"
#import "OrderCreateViewController.h"

@interface GoodsDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CellForSuperProtocol>

@property(nonatomic,strong)WaterFallFlowCollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSDictionary *detailDic;
@property(nonatomic,strong)SelectSizeView *selectView;

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIViews];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"product_id"] = self.productId;
    [[AppData shareData] productProductDetailWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
       
        self.detailDic = dic;
        [self.collectionView reloadData];
    
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIViews {
    
    self.title = @"商品详情";
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
  
    NSMutableArray* flowLayoutArray = [NSMutableArray array];
    for (int i = 0; i< 2; i++) {
        SectionItem* item = [[SectionItem alloc] init];
        item.headerSize = CGSizeMake(320, 0);
        item.footerSize = CGSizeMake(320, 0);
        item.section = i;
        item.minimumInteritemSpacing = 10;
        item.minimumLineSpacing = 10;
        
        item.listAmount = 1;
        item.headerType = SupplementType_Default;
        item.footerType = SupplementType_Default;
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (i == 0) {
            
            item.insets = UIEdgeInsetsMake(0, 0, 0, 0);
            for (int j = 0; j < 1; j ++) {
                
                Item *cellItem = [[Item alloc] init];
                cellItem.width = IOS_IPHONE_WINDOW_WIDE;
                cellItem.height = 400;
                [array addObject:cellItem];
            }
        }else if (i == 1) {
            item.insets = UIEdgeInsetsMake(0, 0, 0, 0);
            for (int j = 0; j < 6; j ++) {
                
                Item *cellItem = [[Item alloc] init];
                cellItem.width = IOS_IPHONE_WINDOW_WIDE;
                if (j == 0) {
                    cellItem.height = 100;
                }else if(j == 1) {
                    
                    cellItem.height = 50;
                }else if(j == 2){
                    
                    cellItem.height = 420;
                }else if(j == 4){
                    
                    cellItem.height = 350;
                }else if(j == 3){
                    cellItem.height = 220;
                }else if(j == 5){
                    
                    cellItem.height = 50;
                }
                
                [array addObject:cellItem];
            }
        }
        item.itemArray = array;
        [flowLayoutArray addObject:item];
    }
    
    WaterFallFlowCollectionViewFlowLayout* flowLayout = [[WaterFallFlowCollectionViewFlowLayout alloc] initWithSectionArray:flowLayoutArray];
    self.flowLayout = flowLayout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = Color_Gray;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"GoodsDetailTopCollectionViewCell") forCellWithReuseIdentifier:@"GoodsDetailTopCollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"DetailDescCollectionViewCell") forCellWithReuseIdentifier:@"DetailDescCollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"DetialListCollectionViewCell") forCellWithReuseIdentifier:@"DetialListCollectionViewCell"];
    
    [collectionView registerNib:WL_NIB(@"DetaiIntroduceCollectionViewCell") forCellWithReuseIdentifier:@"DetaiIntroduceCollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"SelectProductCollectionViewCell") forCellWithReuseIdentifier:@"SelectProductCollectionViewCell"];
    [collectionView registerClass:[DetailRianCollectionViewCell class] forCellWithReuseIdentifier:@"DetailRianCollectionViewCell"];
    [collectionView registerClass:[ProductSuplierCollectionViewCell class] forCellWithReuseIdentifier:@"ProductSuplierCollectionViewCell"];
    [collectionView registerClass:[DetailSameCollectionViewCell class] forCellWithReuseIdentifier:@"DetailSameCollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"DetailMoreCollectionViewCell") forCellWithReuseIdentifier:@"DetailMoreCollectionViewCell"];
    
    
    self.collectionView = collectionView;
    
    UIView *buttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, IOS_IPHONE_WINDOW_HIGH - 64 - 49, IOS_IPHONE_WINDOW_WIDE, 49)];
    buttonBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonBackView];
    [self addButtonView:buttonBackView];
}

- (void)addButtonView:(UIView *)view {
    
    CGFloat wide = 100;
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wide, CGRectGetHeight(view.frame))];
    buyBtn.backgroundColor = Color_Blue;
    buyBtn.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE -wide / 2, buyBtn.center.y);
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:buyBtn];
    [buyBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cartBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(view.frame))];
    cartBtn.backgroundColor = WLColor(86, 242, 149);
    cartBtn.center = CGPointMake(IOS_IPHONE_WINDOW_WIDE - wide/ 2 * 3, buyBtn.center.y);
    [cartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [cartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(cartBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cartBtn];
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
    
        cellID = @"GoodsDetailTopCollectionViewCell";
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cellID = @"DetaiIntroduceCollectionViewCell";
        }else if(indexPath.row == 1){
            
            cellID = @"SelectProductCollectionViewCell";
        }else if(indexPath.row == 2){
            
            cellID = @"DetailRianCollectionViewCell";
        }else if(indexPath.row == 3) {
            
            cellID = @"ProductSuplierCollectionViewCell";
        }else if(indexPath.row == 4) {
            
            cellID = @"DetailSameCollectionViewCell";
        }else if(indexPath.row == 5) {
            
            cellID = @"DetailMoreCollectionViewCell";
        }
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.section == 1) {
        
    
    }else {
        
        GoodsDetailTopCollectionViewCell *theCell = (GoodsDetailTopCollectionViewCell *)cell;
        theCell.delegate = self;
        if (self.detailDic) {
         
            theCell.infoDic = self.detailDic;
        }
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        [self showSize];
    }
}

- (void)showSize {
    
    if (self.selectView == nil) {
        
        self.selectView = [[SelectSizeView alloc] initWithFrame:self.navigationController.view.bounds];
        self.selectView.infoDic = self.detailDic;
        self.selectView.delegate = self;
        [self.navigationController.view addSubview:self.selectView];
        
    }else {
        
        self.selectView.hidden = NO;
    }
    [self.selectView showContent];
}

- (void)cartBtnAction:(UIButton *)sender {
    
    NSLog(@"添加购物车");
    
    [self showSize];
    
//    if ([User share].isLogin) {
//        
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        dic[@"product_id"] = self.detailDic[@"product"][@"product_id"];
//        dic[@"quantity"] = @"1";
//        dic[@"web_site_id"] = [User share].website_id;
//        dic[@"is_increase"] = @"false";
//        [[AppData shareData] userShoppingAddCartWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//            
//            if ([dic[@"code"] intValue] == 0) {
//                
//                [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
//            }
//        }];
//    }
}

- (void)buyBtnAction:(UIButton *)sender {
    
    NSLog(@"购买");
    [self showSize];
}

- (void)proctocolCell:(id)obj withInfo:(NSDictionary *)dic {
    
    if ([obj isKindOfClass:[SelectSizeView class]]) {
        
        [self.selectView removeFromSuperview];
        self.selectView = nil;
        
        if ([User share].isLogin) {
            
            NSString *wlState = dic[@"wl_status"];
            if ([wlState isEqualToString:@"buy"]) {
                
                OrderCreateViewController *orderCreateVC = [[OrderCreateViewController alloc] init];
                orderCreateVC.productDics = @[dic];
                [self.navigationController pushViewController:orderCreateVC animated:YES];
            }else if([wlState isEqualToString:@"addCart"]) {
                
                [self addCartDic:dic];
            }
            
        }else {
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginNavi animated:YES completion:nil];
        }
        
    }
}

- (void)addCartDic:(NSDictionary *)dic {
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    
    dic1[@"product_id"] = dic[@"product_id"];
    dic1[@"quantity"] = dic[@"select_num"];
    dic1[@"web_site_id"] = [User share].website_id;
    dic1[@"is_increase"] = @"false";
    [[AppData shareData] userShoppingAddCartWithInfo:dic1 withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"成功添加购物车"];
        }
    }];
}

@end
