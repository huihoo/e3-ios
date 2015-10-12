//
//  HomeViewController.m
//  E3
//
//  Created by colin liao on 7/27/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "HomeViewController.h"
#import "WaterFallFlowCollectionViewFlowLayout.h"
#import "HomeTopCollectionViewCell.h"
#import "HomeContentCollectionViewCell.h"
#import "HomeBannerCollectionViewCell.h"

#import "GoodsDetailViewController.h"
#import "SearchViewController.h"
#import "ProductListViewController.h"



@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CellForSuperProtocol,UITextFieldDelegate>
{
    NSMutableArray *productList;
}
@property(nonatomic,strong)NSMutableArray *oneItemArray;
@property(nonatomic,strong)NSMutableArray *twoItemArray;
@property(nonatomic,strong)WaterFallFlowCollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)NSMutableArray *homeProducts;
@property(nonatomic,strong)NSMutableArray *bannerLists;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *imageS;
@property(nonatomic,strong)NSMutableArray *nameS;

@end
@implementation HomeViewController

- (NSMutableArray *)homeProducts {
    
    if (!_homeProducts) {
        _homeProducts = [NSMutableArray array];
    }
    return _homeProducts;
}

- (NSMutableArray *)bannerLists {
    
    if (!_bannerLists) {
        _bannerLists = [NSMutableArray array];
    }
    return _bannerLists;
}

- (void)clickRightButton {
    
    [self.tabBarController setSelectedIndex:3];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self prepareData];
    [self setNaviUI];
    [self initUIViews];
    

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"webSiteId"] = @"77";
//    [[AppData shareData] contentPaomadengWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10003";
//    [[AppData shareData] productProductDetailWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"status"] = @"THREE";
//    [[AppData shareData] fistCategoryWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"parent_category_id"] = @"2789";
//    [[AppData shareData] subCategoryWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    long someTime = [[NSDate date] timeIntervalSince1970];
//    dic[@"last_update"] = [NSString stringWithFormat:@"%ld",someTime];
//    [[AppData shareData] hotProductsWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10003";
//    [[AppData shareData] productSuppliersWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];

    
//    dic[@"party_id"] = @"10002";
//    dic[@"page_size"] = @"5";
//    dic[@"page_num"] = @"1";
//    [[AppData shareData] productSupplierProductWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10026";
//    [[AppData shareData] productInventoryNumWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"";
//    dic[@"page_count"] = @"5";
//    dic[@"page_num"] = @"10026";
//    [[AppData shareData] productCommentsWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setNaviUI {

    
    UIImage *rightImage = [UIImage imageNamed:@"cart"];
    [self.rightBtn setImage:rightImage forState:UIControlStateNormal];

    
//    UIImage *leftImage = [UIImage imageNamed:@"iconfont-saomiao (5)"];
//    [self.leftBtn setImage:leftImage forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"E3" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont italicSystemFontOfSize:17];
    UITextField *centerView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.rightBtn.frame))];
    centerView.layer.cornerRadius = CGRectGetHeight(centerView.frame) / 2;
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.leftView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    centerView.leftViewMode = UITextFieldViewModeAlways;
    centerView.rightView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    centerView.rightViewMode = UITextFieldViewModeAlways;
    centerView.font = [UIFont systemFontOfSize:14];
    centerView.placeholder = @"搜索商品";
    self.navigationItem.titleView = centerView;
    centerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [centerView addGestureRecognizer:tapGesture];
}

- (void)prepareData {
    
    productList = [[NSMutableArray alloc] init];
    
    NSArray *imageName = @[@"u12.png",@"u42.png",@"u55.png",@"u68.png"];
    
    for (int i = 0; i < 100; i ++) {
        
        int index =  arc4random() % 4 ;
        
        UIImage *image =[UIImage imageNamed:imageName[index]];
        [productList addObject:image];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    long someTime = [[NSDate date] timeIntervalSince1970];
    dic[@"last_update"] = [NSString stringWithFormat:@"%ld",someTime];
    [[AppData shareData] hotProductsWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        if ([dic[@"code"] intValue] == 0) {
            
            [self.homeProducts addObjectsFromArray:dic[@"hotSaleProducts"]];
            [self.collectionView reloadData];
        }
    }];
 
    NSMutableDictionary *bannerDic =[NSMutableDictionary dictionary];
    bannerDic[@"webSiteId"] = @"77";
    [[AppData shareData] contentPaomadengWithInfo:bannerDic withFinishBlock:^(NSDictionary *dic) {
       
        if ([dic[@"code"] intValue] == 0) {
            
            [self.bannerLists addObjectsFromArray:dic[@"paomadeng"]];
            [self.collectionView reloadData];
        }
    }];
    
    self.imageS = [NSMutableArray array];
    [self.imageS addObject:@"iconfont-fuwu"];
    [self.imageS addObject:@"iconfont-leqi"];
    [self.imageS addObject:@"iconfont-shao05"];
    [self.imageS addObject:@"iconfont-tushu"];
    [self.imageS addObject:@"iconfont-shouji"];
    [self.imageS addObject:@"iconfont-tubiaog"];
    [self.imageS addObject:@"iconfont-yifu"];
    [self.imageS addObject:@"iconfont-yundong101"];
    
    self.nameS = [NSMutableArray array];
    [self.nameS addObject:@"服务"];
    [self.nameS addObject:@"乐器"];
    [self.nameS addObject:@"鞋子"];
    [self.nameS addObject:@"图书"];
    [self.nameS addObject:@"电子"];
    [self.nameS addObject:@"食品"];
    [self.nameS addObject:@"服装"];
    [self.nameS addObject:@"运动"];
}

- (void)initUIViews {
    
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.oneItemArray = [NSMutableArray array];
    self.twoItemArray = [NSMutableArray array];
    
    Item *bannerItem = [[Item alloc] init];
    bannerItem.width = CGRectGetWidth(frame);
    bannerItem.height = 0.33 * bannerItem.width;
    
    
    for (int i = 0; i < 8; i ++) {
    
        Item *item = [[Item alloc] init];
        item.height = 20;
        item.width = 20;
        [self.oneItemArray addObject:item];
    }
    
    for (int i = 0 ; i < 6; i ++) {
        
        Item *item = [[Item alloc] init];
        item.width = (CGRectGetWidth(frame) - 30) / 2;
        UIImage *image = productList[i];
        CGFloat rate = image.size.height / image.size.width;
        item.height = item.width * rate + 60;
        [self.twoItemArray addObject:item];
    }
    
    NSMutableArray* flowLayoutArray = [NSMutableArray array];
    for (int i = 0; i< 3; i++) {
        SectionItem* item = [[SectionItem alloc] init];
        item.section = i;
        item.headerType = SupplementType_Default;
        item.footerType = SupplementType_Default;
        
        
        if (i == 1) {
            //top
            item.listAmount = 4;
            item.minimumInteritemSpacing = 1;
            item.minimumLineSpacing = 1;
            item.itemArray = self.oneItemArray;
            item.footerType = SupplementType_ALL;
            item.footerSize = CGSizeMake(CGRectGetWidth(frame), 0.5);
            item.insets = UIEdgeInsetsMake(0, 0, 5, 0);
        }else if(i == 2){
            //content
            item.listAmount = 2;
            item.minimumInteritemSpacing = 10;
            item.minimumLineSpacing = 10;
            item.itemArray = self.twoItemArray;
            item.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        }else {
            //banner
            item.listAmount = 1;
            item.minimumInteritemSpacing = 0;
            item.minimumLineSpacing = 0;
            item.itemArray = @[bannerItem];
            item.insets = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }
       
        [flowLayoutArray addObject:item];
    }

    
    WaterFallFlowCollectionViewFlowLayout *flowLayout = [[WaterFallFlowCollectionViewFlowLayout alloc] initWithSectionArray:flowLayoutArray];
    self.flowLayout = flowLayout;

    
    frame.size.height -= 69;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView registerNib:WL_NIB(@"HomeTopCollectionViewCell") forCellWithReuseIdentifier:@"HomeTopCollectionViewCell"];
    [collectionView registerNib:WL_NIB(@"HomeContentCollectionViewCell") forCellWithReuseIdentifier:@"HomeContentCollectionViewCell"];
    [collectionView registerClass:[HomeBannerCollectionViewCell class] forCellWithReuseIdentifier:@"HomeBannerCollectionViewCell"];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionReusableView"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.flowLayout.sectionItemArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    SectionItem* item = self.flowLayout.sectionItemArray[section];
    return item.itemArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"CollectionViewCell";
    if (indexPath.section == 1) {
        
        cellID = @"HomeTopCollectionViewCell";
    }else if(indexPath.section == 2){
        cellID = @"HomeContentCollectionViewCell";
    }else {
        cellID = @"HomeBannerCollectionViewCell";
    }
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.section == 2) {
        HomeContentCollectionViewCell *theCell = (HomeContentCollectionViewCell *)cell;
        theCell.delegate = self;
        if (self.homeProducts.count > 0) {
            
            if (indexPath.row <= self.homeProducts.count - 1) {
                
                UIImage *image = productList[indexPath.row];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.homeProducts[indexPath.row]];
                dic[@"image"] = image;
                theCell.infoDic = dic;
            }
        }
    } else if (indexPath.section == 0) {
        
        HomeBannerCollectionViewCell *theCell = (HomeBannerCollectionViewCell *)cell;
        if (self.bannerLists.count > 0) {
            
            theCell.bannerList = self.bannerLists;
        }
        theCell.delegate = self;
    }else if (indexPath.section == 1) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"image"] = self.imageS[indexPath.row];
        dic[@"name"] = self.nameS[indexPath.row];
        HomeTopCollectionViewCell *theCell = (HomeTopCollectionViewCell *)cell;
        theCell.infoDic = dic;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
    view.backgroundColor = [UIColor grayColor];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        NSDictionary *dic = self.homeProducts[indexPath.row];
        GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc] init];
        [goodsDetailVC setValue:dic[@"product_id"] forKey:@"productId"];
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }else if (indexPath.section == 1) {
        
        ProductListViewController *listVC = [[ProductListViewController alloc] init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"category_name"] = self.nameS[indexPath.row];
        listVC.infoDic = dic;
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

- (void)proctocolCell:(id)obj withInfo:(NSDictionary *)dic {
    
    
    if ([obj isKindOfClass:[HomeBannerCollectionViewCell class]]) {
        
        GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc] init];
        [goodsDetailVC setValue:@"SP-10013" forKey:@"productId"];
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }else if ([obj isKindOfClass:[HomeContentCollectionViewCell class]]) {
        
        [self addCollectDic:dic];
    }
    
}

- (void)tapGestureAction:(UITapGestureRecognizer *)gesture {
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)addCollectDic:(NSDictionary *)dic {
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[@"product_id"] = dic[@"product_id"];
    [[AppData shareData] userAddCollectWithInfo:dic1 withFinishBlock:^(NSDictionary *dic) {

        if ([dic[@"code"] intValue] == 0) {
            
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"收藏成功"];
        }
    }];
}

@end
