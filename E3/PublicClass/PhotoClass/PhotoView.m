//
//  PhotoView.m
//  phoneD
//
//  Created by scjh on 15/6/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "PhotoView.h"

#import "PhotoCollectionViewCell.h"
#import "WLPhotoModel.h"
#import "PhotoBroswerVC.h"

static NSString *photoCellID = @"photoCellID";
static CGFloat edgeWide = 10;

@interface PhotoView ()<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PhotoCollectionViewCellDelegate>
{
    CheckPhoto checkPhotoBlock;
    DeletePhoto deletePhotoBlock;
}
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) NSInteger maxNum;
@property(nonatomic,assign) NSInteger currNum;
@property(nonatomic,strong) UIActionSheet *actionSheet;
@property(nonatomic,strong) NSMutableArray *imageS;



@end

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        self.maxNum = 0;
        self.currNum = 1;
        [self UI];
    }
    return self;
}

- (NSMutableArray *)imageS {
    
    if (!_imageS) {
        
        _imageS = [NSMutableArray array];
    }
    return _imageS;
}

- (void)photoViewCheckPhoto:(CheckPhoto)checkPhoto whitDeletePhoto:(DeletePhoto)deletePhoto {
    
    checkPhotoBlock = checkPhoto;
    deletePhotoBlock = deletePhoto;
}

- (void)UI {
    
    //初始化一个flow值
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(0, 0);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:photoCellID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}



- (void)setItemSize:(CGSize)itemSize {
    
    _itemSize = itemSize;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = itemSize;
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = edgeWide;
    edgeInsets.bottom = edgeWide;
    edgeInsets.right = edgeWide;
    edgeInsets.left = edgeWide;
    flowLayout.sectionInset = edgeInsets;
    self.collectionView.collectionViewLayout = flowLayout;
    self.maxNum = [self numberOfItems:itemSize];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfItems:(CGSize)itemSize {

    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat allWide = CGRectGetWidth(self.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right;
    CGFloat allHigh = CGRectGetHeight(self.frame) - flowLayout.sectionInset.top - flowLayout.sectionInset.bottom;
    NSInteger nNum = (allWide + flowLayout.minimumInteritemSpacing) / (itemSize.width + flowLayout.minimumInteritemSpacing);
    NSInteger mNum = (allHigh + flowLayout.minimumLineSpacing) / (itemSize.height + flowLayout.minimumLineSpacing);
    
    CGFloat nBetween = (CGRectGetWidth(self.frame) - nNum * itemSize.width ) / (nNum + 1);
    CGFloat mBetween = (CGRectGetHeight(self.frame) - mNum * itemSize.height ) / (mNum + 1);
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = edgeInsets.bottom = mBetween;
    edgeInsets.right = edgeInsets.left = nBetween;
    flowLayout.sectionInset = edgeInsets;
    flowLayout.minimumLineSpacing = mBetween;
    flowLayout.minimumInteritemSpacing = nBetween;
    self.collectionView.collectionViewLayout = flowLayout;
    return nNum * mNum;
}

#pragma mark - collectionView的代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.currNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellID forIndexPath:indexPath];
    cell.delegate = self;
    
        
        if (self.imageS.count != self.maxNum) {
            
            if (indexPath.row < self.currNum - 1) {
                
                UIImage *image = self.imageS[indexPath.row];
                cell.infoDic = @{@"image":image};
            }else {
                cell.infoDic = @{@"image":@""};
            }
        }else {
            
            UIImage *image = self.imageS[indexPath.row];
            cell.infoDic = @{@"image":image};
        }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.currNum - 1 && self.imageS.count != self.maxNum) {
        
        if (self.actionSheet == nil) {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
            [actionSheet showInView:self];
            self.actionSheet = actionSheet;
        }else {
            
            [self.actionSheet showInView:self];
        }
        
    }else {
        
        
        PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        UIViewController *theVC = (UIViewController *)self.delegate;
        
        NSMutableArray *allImageViews = [NSMutableArray array];
        
        for (int i = 0 ; i < self.imageS.count; i ++) {
            
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
            PhotoCollectionViewCell *cell1 = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath1];
            [allImageViews addObject:cell1.imageView];
        }

        
        [PhotoBroswerVC show:theVC superView:self.collectionView type:PhotoBroswerVCTypeZoom index:indexPath.row photoModelBlock:^NSArray *{
            
            
            NSArray *networkImages=[@[
                                     @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
                                     @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
                                     @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
                                     @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
                                     @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
                                     
                                     @"http://www.netbian.com/d/file/20140522/3e939daa0343d438195b710902590ea0.jpg",
                                     
                                     @"http://www.netbian.com/d/file/20141018/7ccbfeb9f47a729ffd6ac45115a647a3.jpg",
                                     
                                     @"http://www.netbian.com/d/file/20140724/fefe4f48b5563da35ff3e5b6aa091af4.jpg",
                                     
                                     @"http://www.netbian.com/d/file/20140529/95e170155a843061397b4bbcb1cefc50.jpg"
                                     ] mutableCopy];
            
            
            NSArray *localImages = self.imageS;
            
            NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
            for (NSUInteger i = 0; i< localImages.count; i++) {
                
                PhotoModel *pbModel=[[PhotoModel alloc] init];
                pbModel.mid = i + 1;
            /**添加文字说明*/
//                pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//                pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
                /*加载本地图片*/
                pbModel.image = localImages[i];
                /*加载网络图片*/
//                pbModel.image_HD_U = networkImages[i];
                
                //源frame
                UIImageView *imageV = cell.imageView;
                pbModel.sourceImageView = imageV;
                
                pbModel.sourceAllImageViews = allImageViews;
                
                [modelsM addObject:pbModel];
            }
            
            return modelsM;

            
        }];
    }
    
}

#pragma mark ActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSInteger index = 0;
    switch (buttonIndex) {
        case 2:
            index = 1;
            break;
        case 1:
            index = 2;
            break;
        case 0:
            index = 3;
            break;
        default:
            break;
    }
    if (self.delegate) {
    
        NSDictionary *dic = @{@"index":@(index)};
        [WLPhotoModel photoModelActionObjectVC:self.delegate withDelegate:self withInfo:dic];
    }
}

#pragma mark imagePickerVCdelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editImage = info[UIImagePickerControllerEditedImage];
    [self.imageS addObject:editImage];
    self.currNum ++;
    if (self.currNum >= self.maxNum) {
        
        self.currNum = self.maxNum;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
    if (checkPhotoBlock != nil) {
        
        NSDictionary *dic = @{@"image":editImage,@"index":@(self.currNum)};
        checkPhotoBlock(dic);
    }
}

#pragma mark - PhotoCollectionViewCellDelegate方法
- (void)photoCollectionViewCellDelegate:(PhotoCollectionViewCell *)objCell {
    
    NSInteger index = [self.imageS indexOfObject:objCell.imageView.image];
    [self.imageS removeObject:objCell.imageView.image];
    self.currNum --;
    [self.collectionView reloadData];
    if (deletePhotoBlock != nil) {
        NSDictionary *dic = @{@"image":objCell.imageView.image,@"index":@(index)};
        deletePhotoBlock(dic);
    }
}

@end
