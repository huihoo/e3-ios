//
//  MineViewController.m
//  E3
//
//  Created by colin liao on 7/27/15.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "MineViewController.h"
#import "MineCollectionViewCell.h"
#import "MineHeadCollectionViewCell.h"
#import "MineHeaderCollectionReusableView.h"
#import "WaterFallFlowCollectionViewFlowLayout.h"
#import "MineItem.h"
#import "ChangePasswordViewController.h"
#import "ChangeEmailViewController.h"
#import "BHyjdPaswordHelper.h"
#import "ChangePassViewController.h"
#import "OrderViewController.h"
#import "AddressListViewController.h"

NSString* kMineCollectionViewCell = @"MineCollectionViewCell";
NSString* kMineHeaderCollectionReusableView = @"MineHeaderCollectionReusableView";

@interface MineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(weak,nonatomic)IBOutlet UICollectionView* mineCollectionView;
@property(nonatomic,strong)NSMutableArray* flowLayoutArray;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"user_name"] = @"hezhoujun";
//    dic[@"pwd"] = @"123456";
//    [[AppData shareData] userLoginWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
    
    
//    dic[@"account"] = @"15882216368";
//    dic[@"pwd"] = @"123456";
//    dic[@"website_id"] = @"www";//注册时为固定的www；
//    [[AppData shareData] userRegisterWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"user_login_id"] = @"1";
//    dic[@"uuid"] = @"1";
//    [[AppData shareData] userCheckCodeWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"user_login_id"] = @"hezhoujun";
//    dic[@"password"] = @"123456";
//    dic[@"confirmPwd"] = @"123456";
//    dic[@"uuid"] = @"1";
//    [[AppData shareData] userFindPwdWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"website_id"] = @"77";
//    [[AppData shareData] userLoginAuthWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
    //待验证
//    dic[@"linktel"] = @"13881111750";
//    dic[@"qq"] = @"332141424";
//    dic[@"name"] = @"hezhoujun";
//    dic[@"servicephone"] = @"028843983";
//    dic[@"siteName"] = @"hezhoujun";
//    [[AppData shareData] userChangeInfoWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];

//    dic[@"account"] = @"532876443@qq.com";
//    dic[@"pwd"] = @"123456";
//    dic[@"login_status"] = @"2";
//    dic[@"query"] = @"1";
//    dic[@"query_cloumn"] = @"all";
//    [[AppData shareData] userInfoWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
    //待验证
//    dic[@"account"] = @"hezhoujun";
//    [[AppData shareData] userVerificationWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"methods"] = @"save";//save update delete select
//    dic[@"addressname"] = @"wangliang";
//    dic[@"addressphone"] = @"13881111750";
//    dic[@"proviceId"] = @"sichuang";
//    dic[@"cityId"] = @"cd";
//    dic[@"countryId"] = @"sd";
//    dic[@"address"] = @"wanglang";
//    [[AppData shareData] userAddressWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"accout"] = @"hezhoujun";
//    [[AppData shareData] userAddressListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
    
//    dic[@"old_pwd"] = @"123456";
//    dic[@"new_pwd"] = @"1234567";
//    dic[@"confirm_pwd"] = @"1234567";
//    [[AppData shareData] userChangePwdWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"user_pwd"] = @"1234567";
//    dic[@"pay_pwd"] = @"123456";
//    dic[@"confirm_pay_pwd"] = @"123456";
//    [[AppData shareData] userPayPwdWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"old_pay_pwd"] = @"123456";
//    dic[@"new_pay_pwd"] = @"1234567";
//    dic[@"confirm_new_pay_pwd"] = @"1234567";
//    [[AppData shareData] userPayChangePwdWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    

//    UIImage *image = [UIImage imageNamed:@"gou"];
//    NSData *data=UIImagePNGRepresentation(image);
//    NSData * data1 = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSString *result = [[NSString alloc] initWithData:data1  encoding:NSUTF8StringEncoding];
//    NSString*stringdd= [BHyjdPaswordHelper encodeToPercentEscapeString:result];
//    dic[@"state"] = @"png";
//    dic[@"imagepath"] = stringdd;
//    [[AppData shareData] userHeaderImageWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"user_login_id"] = @"15882216368";
//    [[AppData shareData] userSendMessageWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10003";
//    [[AppData shareData] userAddCollectWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"page"] = @"1";
//    dic[@"page_size"] = @"10";
//    [[AppData shareData] userCollectListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10003";
//    [[AppData shareData] userAddLikeWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"page"] = @"1";
//    dic[@"page_size"] = @"10";
//    [[AppData shareData] userLikeListWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10003";
//    [[AppData shareData] userDeleteLikeWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
//    dic[@"product_id"] = @"10003";
//    [[AppData shareData] userDeleteCollectWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
//        
//    }];
    
    dic[@"type"] = @"1";
    [[AppData shareData] userMessageWithInfo:dic withFinishBlock:^(NSDictionary *dic) {
        
    }];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)initUI {
    
    self.navigationController.navigationBar.barTintColor = WLColor(83, 212, 184);
    self.navigationItem.title = @"我的E3";
    
    self.mineCollectionView.dataSource = self;
    self.mineCollectionView.delegate = self;
    
    
    
    //初始化布局数组
    self.flowLayoutArray = [NSMutableArray array];
    [self prepareData];
    WaterFallFlowCollectionViewFlowLayout* flowlayout = [[WaterFallFlowCollectionViewFlowLayout alloc] initWithSectionArray:self.flowLayoutArray];
    self.mineCollectionView.collectionViewLayout = flowlayout;
    
    [self.mineCollectionView registerNib:WL_NIB(kMineCollectionViewCell) forCellWithReuseIdentifier:kMineCollectionViewCell];
    [self.mineCollectionView registerNib:WL_NIB(kMineHeaderCollectionReusableView) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMineHeaderCollectionReusableView];
    [self.mineCollectionView registerNib:WL_NIB(kMineHeaderCollectionReusableView) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kMineHeaderCollectionReusableView];
    [self.mineCollectionView registerNib:WL_NIB(@"MineHeadCollectionViewCell") forCellWithReuseIdentifier:@"MineHeadCollectionViewCell"];
}

- (void)prepareData {
    
    //初始化cell信息
    
    MineItem* mineItem0 = [[MineItem alloc] init];
    mineItem0.height = 140;
    mineItem0.width = 320;
    mineItem0.imageName = @"note_memo";
    mineItem0.itemTypeName = @"我的订单";
    
    
    MineItem* mineItem1 = [[MineItem alloc] init];
    mineItem1.height = 45;
    mineItem1.width = 320;
    mineItem1.imageName = @"note_memo";
    mineItem1.itemTypeName = @"我的订单";
    
    MineItem* mineItem1_1 = [[MineItem alloc] init];
    mineItem1_1.height = 45;
    mineItem1_1.width = 320;
    mineItem1_1.imageName = @"note_memo";
    mineItem1_1.itemTypeName = @"我的地址";
    
    MineItem* mineItem2 = [[MineItem alloc] init];
    mineItem2.height = 45;
    mineItem2.width = 320;
    mineItem2.imageName = @"email";
    mineItem2.itemTypeName = @"修改邮箱";
    
    MineItem* mineItem3 = [[MineItem alloc] init];
    mineItem3.height = 45;
    mineItem3.width = 320;
    mineItem3.imageName = @"lock";
    mineItem3.itemTypeName = @"修改密码";
    
    MineItem* mineItem4 = [[MineItem alloc] init];
    mineItem4.height = 45;
    mineItem4.width = 320;
    mineItem4.imageName = @"smile";
    mineItem4.itemTypeName = @"用户反馈";
    
    SectionItem* item0 = [[SectionItem alloc] init];
    item0.section = 0;
    item0.listAmount = 1;
    item0.headerType = SupplementType_Default;
    item0.headerSize = CGSizeMake(320, 140);
    item0.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    item0.itemArray = [NSArray arrayWithObjects:mineItem0, nil];
    [self.flowLayoutArray addObject:item0];

    
    SectionItem* item1 = [[SectionItem alloc] init];
    item1.section = 1;
    item1.listAmount = 1;
    item1.minimumLineSpacing = 0;
    item1.insets = UIEdgeInsetsMake(18, 0, 0, 0);
    item1.itemArray = [NSArray arrayWithObjects:mineItem1,mineItem1_1,nil];
    [self.flowLayoutArray addObject:item1];
    
    
    SectionItem* item2 = [[SectionItem alloc] init];
    item2.section = 2;
    item2.listAmount = 1;
    item2.minimumLineSpacing = 0;
    item2.insets = UIEdgeInsetsMake(18, 0, 0, 0);
    item2.itemArray = [NSArray arrayWithObjects:mineItem2,mineItem3, nil];
    [self.flowLayoutArray addObject:item2];
    
    
    
    SectionItem* item3 = [[SectionItem alloc] init];
    item3.section = 3;
    item3.listAmount = 1;
    item3.insets = UIEdgeInsetsMake(18, 0, 0, 0);
    item3.itemArray = [NSArray arrayWithObjects:mineItem4,nil];
    [self.flowLayoutArray addObject:item3];
    
    MineItem* mineItem5 = [[MineItem alloc] init];
    mineItem5.height = 45;
    mineItem5.width = 320;
    mineItem5.itemTypeName = @"安全退出登录";
    
    SectionItem* item4 = [[SectionItem alloc] init];
    item4.section = 4;
    item4.listAmount = 1;
    item4.insets = UIEdgeInsetsMake(18, 0, 0, 0);
    item4.itemArray = [NSArray arrayWithObjects:mineItem5,nil];
    [self.flowLayoutArray addObject:item4];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.flowLayoutArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SectionItem* item = [self.flowLayoutArray objectAtIndex:section];
    return item.itemArray.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        MineHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineHeadCollectionViewCell" forIndexPath:indexPath];
        cell.infoDic = nil;
        return cell;
        
    }else {
        
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMineCollectionViewCell forIndexPath:indexPath];
        if (5 != indexPath.section) {
            MineCollectionViewCell* mineCell = (MineCollectionViewCell*)cell;
            SectionItem* item = self.flowLayoutArray[indexPath.section];
            BOOL isShow = false;
            if (item.itemArray.count-1 != indexPath.row) {
                isShow = true;
            }
            [mineCell initWithMineItem:item.itemArray[indexPath.row] withLine:isShow];
            mineCell.hidden = NO;
            if (indexPath.section == 4) {
                
                mineCell.hidden = ![User share].isLogin;
            }
        }
        return cell;
        
    }
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MineHeaderCollectionReusableView* headerReusableView;
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kMineHeaderCollectionReusableView forIndexPath:indexPath];
        [headerReusableView refreshView];
    }else
    {
        headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kMineHeaderCollectionReusableView forIndexPath:indexPath];
    }
    
    return headerReusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([User share].isLogin) {
        
        if (1 == indexPath.section) {
            switch (indexPath.row) {
                case 0:
                    [self.navigationController pushViewController:[[OrderViewController alloc] init] animated:YES];
                    break;
                    
                case 1:
                    [self.navigationController pushViewController:[[AddressListViewController alloc] init] animated:YES];
                default:
                    break;
            }
        }else if (4 == indexPath.section) {
            
            [[User share] removeUserInfo];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut:) name:@"loginOut" object:nil];
            
        }else if (2 == indexPath.section && 1 == indexPath.row) {
            
            ChangePassViewController *changeVC = [[ChangePassViewController alloc] init];
            [self.navigationController pushViewController:changeVC animated:YES];
        }else if (3 == indexPath.section) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"用户反馈" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView show];
        }else if (2 == indexPath.section && 0 == indexPath.row) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"修改邮箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }else {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginIn:) name:@"LoginIn" object:nil];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNavi animated:YES completion:nil];
    }
    
}

- (void)loginIn:(NSNotification *)notice {
    
    [self.mineCollectionView reloadData];
    
}

- (void)loginOut:(NSNotification *)notice {
    
    [self.mineCollectionView reloadData];
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoignIn" object:nil];
}

@end
