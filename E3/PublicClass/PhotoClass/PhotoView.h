//
//  PhotoView.h
//  phoneD
//
//  Created by scjh on 15/6/29.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CheckPhoto)(NSDictionary *infoDic);
typedef void(^DeletePhoto)(NSDictionary *infoDic);

typedef enum : NSUInteger {
    
    StateEditing = 0,//编辑
    StateCheck//查看
} State;//状态

typedef enum :NSUInteger {
    
    ScrollDirectionH = 0,//横向
    ScrollDirectionV//纵向
} ScrollDirection;

@interface PhotoView : UIView

@property(nonatomic,assign) CGSize itemSize;


//delegate为VC 
@property(nonatomic,assign) id<UIImagePickerControllerDelegate,UINavigationControllerDelegate> delegate;

//选择回调
- (void)photoViewCheckPhoto:(CheckPhoto)checkPhoto whitDeletePhoto:(DeletePhoto)deletePhoto;

@end
