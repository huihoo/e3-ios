//
//  CateGoryViewController.m
//  E3
//
//  Created by colin liao on 7/27/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "CateGoryViewController.h"
#import "CategoryCollectionViewCell.h"
#import "ProductListViewController.h"

typedef enum {
    
    CategoryStateFirst,
    CategoryStateSecond
} CategoryState;

@interface CateGoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *firstArray;
@property(nonatomic,strong)NSArray *secondArray;

@property(nonatomic,strong)UICollectionView *firstCollectionView;
@property(nonatomic,strong)UICollectionView *secondCollectionView;
@property(nonatomic,strong)CategoryCollectionViewCell *lastCell;

@end

@implementation CateGoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"分类";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"status"] = @"THREE";
    [[AppData shareData] fistCategoryWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            self.firstArray = dic[@"result"];
            [self.firstCollectionView reloadData];
            [self obationSubCategorySuperDic:self.firstArray[0]];
        }
    }];
    
    [self initViews];
}

- (void)obationSubCategorySuperDic:(NSDictionary *)infoDic {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"parent_category_id"] = infoDic[@"product_category_id"];
    [[AppData shareData] subCategoryWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
        if ([dic[@"code"] intValue] == 0) {
            
            self.secondArray = dic[infoDic[@"product_category_id"]];
            [self.secondCollectionView reloadData];
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initViews {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat firstWide = (1 - 0.6132) * IOS_IPHONE_WINDOW_WIDE;
    CGRect frame = CGRectMake(0, 0, 0, IOS_IPHONE_WINDOW_HIGH - 49);
    frame.size.width = firstWide;
    
    flowLayout.itemSize = CGSizeMake(firstWide, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    UICollectionView *firstCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    firstCollectionView.tag = 1;
    firstCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstCollectionView];
    firstCollectionView.delegate = self;
    firstCollectionView.dataSource = self;
//    [firstCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [firstCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    self.firstCollectionView = firstCollectionView;
    
    
    UICollectionViewFlowLayout *secondFlowout = [[UICollectionViewFlowLayout alloc] init];
    secondFlowout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    secondFlowout.itemSize = CGSizeMake(IOS_IPHONE_WINDOW_WIDE - firstWide, 30);
    CGRect secframe = CGRectMake(0, 0, 0, IOS_IPHONE_WINDOW_HIGH);
    secframe.size.width = IOS_IPHONE_WINDOW_WIDE - firstWide;
    secframe.origin.x = CGRectGetMaxX(firstCollectionView.frame);

    UICollectionView *secondCollectionView = [[UICollectionView alloc] initWithFrame:secframe collectionViewLayout:secondFlowout];
    secondCollectionView.tag = 2;
    secondCollectionView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
    [self.view addSubview:secondCollectionView];
    secondCollectionView.delegate = self;
    secondCollectionView.dataSource = self;
//    [secondCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [secondCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    self.secondCollectionView = secondCollectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView.tag == 1) {
        
        return self.firstArray.count;
    }else if(collectionView.tag == 2) {
        
        return self.secondArray.count;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"CategoryCollectionViewCell";
    if (collectionView.tag == 1 && collectionView.tag == 2) {
        
        cellID = @"CategoryCollectionViewCell";
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    
    CategoryCollectionViewCell *theCell = (CategoryCollectionViewCell *)cell;
    if (collectionView.tag == 1) {
        
        theCell.infoDic = self.firstArray[indexPath.row];
        if (indexPath.row == 0) {
            
            theCell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
            self.lastCell = theCell;
        }else {
            theCell.backgroundColor = [UIColor whiteColor];
        }
    }else if(collectionView.tag == 2) {
        
        theCell.infoDic = self.secondArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1) {
        
        self.lastCell.backgroundColor = [UIColor whiteColor];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
        self.lastCell = (CategoryCollectionViewCell *)cell;
        [self obationSubCategorySuperDic:self.firstArray[indexPath.row]];
    }else if (collectionView.tag == 2) {
    
        ProductListViewController *productListVC = [[ProductListViewController alloc] init];
        productListVC.infoDic = self.secondArray[indexPath.row];
        [self.navigationController pushViewController:productListVC animated:YES];
    }
}

@end
