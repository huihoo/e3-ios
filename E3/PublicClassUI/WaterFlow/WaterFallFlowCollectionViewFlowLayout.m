//
//  WaterFallFlowCollectionViewFlowLayout.m
//  WaterFallFlow
//
//  Created by colin liao on 15/6/12.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WaterFallFlowCollectionViewFlowLayout.h"

@interface WaterFallFlowCollectionViewFlowLayout ()
@property(nonatomic)CGFloat allHeight;
@property(nonatomic,strong)NSMutableArray* layoutAttributesArray;
@property(nonatomic,strong)NSMutableArray* sectionHeightArray;

@end

@implementation WaterFallFlowCollectionViewFlowLayout
-(instancetype)initWithSectionArray:(NSMutableArray*)sectionItemArray
{
    self = [super init];
    self.sectionItemArray = sectionItemArray;
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    self.sectionHeightArray = [NSMutableArray array];
    self.layoutAttributesArray = [NSMutableArray array];
}


-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSInteger sectionAcount = self.sectionItemArray.count;
    
    for (int i = 0; i < sectionAcount; i++) {
        [self SetSectionHeightArrayWithSectionItem:[self.sectionItemArray objectAtIndex:i]];
    }
    for (int i = 0; i < sectionAcount; i++) {
        [self setOneSectionAttributesWithSectionItem:[self.sectionItemArray objectAtIndex:i]];
    }
    return self.layoutAttributesArray;
}

-(void)SetSectionHeightArrayWithSectionItem:(SectionItem*)sectionItem
{
    CGFloat rowWidth =  self.collectionView.frame.size.width - sectionItem.insets.left - sectionItem.insets.right;
    CGFloat itemWith =  (rowWidth - sectionItem.minimumInteritemSpacing*(sectionItem.listAmount - 1))/sectionItem.listAmount;
    
    CGFloat listHeight[sectionItem.listAmount];
    CGFloat listItemCount[sectionItem.listAmount];
    
    
    NSInteger index = 0;
    for (int i = 0; i < sectionItem.listAmount; i++) {
        listHeight[i] = [self getHeaderSizeOfOneSection:sectionItem] + sectionItem.insets.top;
        listItemCount[i] = 0;
    }
    for (Item* item in sectionItem.itemArray) {
        
        NSInteger shortList = [self getShortList:listHeight withListNumber:sectionItem.listAmount];
        
        listItemCount[shortList]++;
        
        CGFloat itemPositionX = sectionItem.insets.left + (itemWith + sectionItem.minimumInteritemSpacing)*shortList;
        
        CGFloat itemPositionY = listHeight[shortList];
        
//        NSLog(@"%f,%f",itemPositionX,itemPositionY);
        
        CGFloat itemHeight = item.height * (itemWith/item.width);
        
        
        listHeight[shortList] = listHeight[shortList] + sectionItem.minimumLineSpacing + itemHeight;
        index ++;
    }
    
    NSInteger longList = [self getLongList:listHeight withListNumber:sectionItem.listAmount];
    
    CGFloat curHeight = listHeight[longList] - sectionItem.minimumInteritemSpacing + sectionItem.insets.bottom;
    self.allHeight = curHeight + [self getFooterSizeOfOneSection:sectionItem] + sectionItem.minimumSectionLineSpacing;
    [self.sectionHeightArray addObject:[[NSNumber alloc] initWithFloat:self.allHeight]];
}


-(void)setOneSectionAttributesWithSectionItem:(SectionItem*)sectionItem
{
    CGFloat rowWidth =  self.collectionView.frame.size.width - sectionItem.insets.left - sectionItem.insets.right;
    CGFloat itemWith =  (rowWidth - sectionItem.minimumInteritemSpacing*(sectionItem.listAmount - 1))/sectionItem.listAmount;
    
    CGFloat listHeight[sectionItem.listAmount];
    CGFloat listItemCount[sectionItem.listAmount];
    
    NSInteger index = 0;
    for (int i = 0; i < sectionItem.listAmount; i++) {
        listHeight[i] = [self getHeaderAttributesOfOneSection:sectionItem] + sectionItem.insets.top;
        listItemCount[i] = 0;
    }
    
    
    for (Item* item in sectionItem.itemArray) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:index inSection:sectionItem.section];
        UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        
        NSInteger shortList = [self getShortList:listHeight withListNumber:sectionItem.listAmount];
        
        listItemCount[shortList]++;
        
        CGFloat itemPositionX = sectionItem.insets.left + (itemWith + sectionItem.minimumInteritemSpacing)*shortList;
        
        CGFloat itemPositionY = listHeight[shortList];
        
//        NSLog(@"%f,%f",itemPositionX,itemPositionY);
        
        CGFloat itemHeight = item.height * (itemWith/item.width);
        
        attributes.frame = CGRectMake(itemPositionX, itemPositionY + [self getSectionHeightWihtCurSection:sectionItem.section], itemWith, itemHeight);
        
        [self.layoutAttributesArray addObject:attributes];
        
        
        listHeight[shortList] = listHeight[shortList] + sectionItem.minimumLineSpacing + itemHeight;
        index ++;
    }
    
    NSInteger longList = [self getLongList:listHeight withListNumber:sectionItem.listAmount];
    CGFloat curHeight = listHeight[longList] - sectionItem.minimumInteritemSpacing + sectionItem.insets.bottom;
    [self getFooterAttributesOfOneSection:sectionItem withCurHeight:curHeight];
    
}

-(CGFloat)getHeaderSizeOfOneSection:(SectionItem*)sectionItem
{
    CGFloat headerWidth = 0;
    if (SupplementType_Left == sectionItem.headerType) {
        headerWidth = self.collectionView.frame.size.width - sectionItem.insets.left;
    }else if(SupplementType_Right == sectionItem.headerType)
    {
        headerWidth = self.collectionView.frame.size.width - sectionItem.insets.right;
    }else if(SupplementType_LeftRight == sectionItem.headerType)
    {
        headerWidth = self.collectionView.frame.size.width - sectionItem.insets.left - sectionItem.insets.right;
    }else if(SupplementType_ALL == sectionItem.headerType)
    {
        headerWidth = self.collectionView.frame.size.width;
    }
    
    CGFloat headerHeight;
    
    if (SupplementType_Default == sectionItem.headerType) {
        headerHeight = 0;
    }else
    {
        headerHeight = sectionItem.headerSize.height*(headerWidth/sectionItem.headerSize.width);
    }
    
    
    return headerHeight;
}

-(CGFloat)getHeaderAttributesOfOneSection:(SectionItem*)sectionItem
{
    CGFloat headerPositionX = 0;
    CGFloat headerWidth = 0;
    
    if (SupplementType_Left == sectionItem.headerType) {
        headerPositionX = sectionItem.insets.left;
        headerWidth = self.collectionView.frame.size.width - sectionItem.insets.left;
    }else if(SupplementType_Right == sectionItem.headerType)
    {
        headerPositionX = 0;
        headerWidth = self.collectionView.frame.size.width - sectionItem.insets.right;
    }else if(SupplementType_LeftRight == sectionItem.headerType)
    {
        headerPositionX = sectionItem.insets.left;
        headerWidth = self.collectionView.frame.size.width - sectionItem.insets.left - sectionItem.insets.right;
    }else if(SupplementType_ALL == sectionItem.headerType)
    {
        headerPositionX = 0;
        headerWidth = self.collectionView.frame.size.width;
    }
    
    
    CGFloat headerHeight;
    
    if (SupplementType_Default == sectionItem.headerType) {
        headerHeight = 0;
    }else
    {
        headerHeight = sectionItem.headerSize.height*(headerWidth/sectionItem.headerSize.width);
    }
    
    NSIndexPath* headerIndexPath = [NSIndexPath indexPathForItem:0 inSection:sectionItem.section];
    UICollectionViewLayoutAttributes* headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:headerIndexPath];
    headerAttributes.frame = CGRectMake(headerPositionX, [self getSectionHeightWihtCurSection:sectionItem.section], headerWidth, headerHeight);
    
    [self.layoutAttributesArray addObject:headerAttributes];
    
    return headerHeight;
}


-(CGFloat)getFooterSizeOfOneSection:(SectionItem*)sectionItem
{
    CGFloat footerWidth = 0;
    
    if (SupplementType_Left == sectionItem.footerType) {
        footerWidth = self.collectionView.frame.size.width - sectionItem.insets.left;
    }else if(SupplementType_Right == sectionItem.footerType)
    {
        footerWidth = self.collectionView.frame.size.width - sectionItem.insets.right;
    }else if(SupplementType_LeftRight == sectionItem.footerType)
    {
        footerWidth = self.collectionView.frame.size.width - sectionItem.insets.left - sectionItem.insets.right;
    }else if(SupplementType_ALL == sectionItem.footerType)
    {
        footerWidth = self.collectionView.frame.size.width;
    }
    
    CGFloat footerHeight;
    if (SupplementType_Default == sectionItem.footerType) {
        footerHeight = 0;
    }else
    {
        footerHeight = sectionItem.footerSize.height*(footerWidth/sectionItem.footerSize.width);
    }
    
    return footerHeight;
}

-(CGFloat)getFooterAttributesOfOneSection:(SectionItem*)sectionItem withCurHeight:(CGFloat)curHeight
{
    CGFloat footerPositionX = 0;
    CGFloat footerWidth = 0;
    
    if (SupplementType_Left == sectionItem.footerType) {
        footerPositionX = sectionItem.insets.left;
        footerWidth = self.collectionView.frame.size.width - sectionItem.insets.left;
    }else if(SupplementType_Right == sectionItem.footerType)
    {
        footerPositionX = 0;
        footerWidth = self.collectionView.frame.size.width - sectionItem.insets.right;
    }else if(SupplementType_LeftRight == sectionItem.footerType)
    {
        footerPositionX = sectionItem.insets.left;
        footerWidth = self.collectionView.frame.size.width - sectionItem.insets.left - sectionItem.insets.right;
    }else if(SupplementType_ALL == sectionItem.footerType)
    {
        footerPositionX = 0;
        footerWidth = self.collectionView.frame.size.width;
    }
    
    CGFloat footerHeight;
    if (SupplementType_Default == sectionItem.footerType) {
        footerHeight = 0;
    }else
    {
        footerHeight = sectionItem.footerSize.height*(footerWidth/sectionItem.footerSize.width) ;
    }
    
    NSIndexPath* headerIndexPath = [NSIndexPath indexPathForItem:0 inSection:sectionItem.section];
    UICollectionViewLayoutAttributes* headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:headerIndexPath];
    headerAttributes.frame = CGRectMake(footerPositionX, curHeight + [self getSectionHeightWihtCurSection:sectionItem.section], footerWidth, footerHeight);
    
    [self.layoutAttributesArray addObject:headerAttributes];
    
    return footerHeight;
}

-(CGFloat)getSectionHeightWihtCurSection:(NSInteger)section
{
    CGFloat height = 0.0;
    for (int i = 0; i < section; i++) {
        NSNumber* number = [self.sectionHeightArray objectAtIndex:i];
        height = height + number.floatValue;
    }
    return height;
}

-(NSInteger)getItemListCount:(NSInteger*)listItemCount withListNumber:(NSInteger)listNumber
{
    NSInteger count  = 0;
    for (int i =0 ; i< listNumber; i++) {
        count += listItemCount[i] ;
    }
    return count;
}

-(NSInteger)getShortList:(CGFloat*)listHeight withListNumber:(NSInteger)listNumber
{
    CGFloat max = CGFLOAT_MAX;
    
    NSInteger list = 0;
    for (int i = 0;  i<listNumber; i++) {
        if (listHeight[i] < max) {
            max = listHeight[i];
            list = i;
        }
    }
    
    return list ;
}

-(NSInteger)getLongList:(CGFloat*)listHeight withListNumber:(NSInteger)listNumber
{
    CGFloat min = 0;
    NSInteger list = 0;
    for (int i = 0; i < listNumber; i++) {
        if (listHeight[i] > min) {
            min = listHeight[i];
            list = i;
        }
    }
    return list;
}


-(CGSize)collectionViewContentSize
{
    CGSize size ;
    if (self.sectionHeightArray.count <= 0) {
        size = CGSizeMake(self.collectionView.frame.size.width, 0);
    }else
    {
        size = CGSizeMake(self.collectionView.frame.size.width, [self getSectionHeightWihtCurSection:[self.collectionView numberOfSections]]);
    }
    return size;
}

@end



@implementation SectionItem

-(instancetype)init
{
    self = [super init];
    //初始化值
    self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumSectionLineSpacing = 5;
    self.minimumInteritemSpacing = 5;
    self.minimumLineSpacing = 5;
    self.headerType = SupplementType_Default;
    self.footerType = SupplementType_Default;
    self.headerSize = CGSizeMake(300, 50);
    self.footerSize = CGSizeMake(300, 50);
    
    return self;
}

@end


@implementation Item


@end
