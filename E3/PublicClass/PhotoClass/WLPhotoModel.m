//
//  PhotoModel.m
//  newShop
//
//  Created by scjh on 15/5/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import "WLPhotoModel.h"

@implementation WLPhotoModel

+ (void)photoModelObject:(id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)theVC
            withDelegate:(id)objDelegate
        pickerSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = objDelegate;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [(UIViewController *)theVC presentViewController:picker animated:YES completion:nil];//进入照相界面
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    NSString *str = nil;
    
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        str  = @"照片";
    }else if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        str = @"相机";
    }
    switch (status) {
        case AVAuthorizationStatusDenied:
        {
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *appName = infoDic[@"CFBundleDisplayName"];
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"无法开启%@",str]
                                       message:[NSString stringWithFormat:@"请为恋味开放%@权限:设置->%@->%@(开启)",str,appName,str]
                                      delegate:theVC
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil];
            alertView.tag = 10;
            [alertView show];
            return;
        }
            break;
            
        default:
            break;
    }
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        
        if (!granted) {
            
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];

}

+ (void)photoModelActionObjectVC:(id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)theVC
                    withDelegate:(id)objDelegate
                        withInfo:(NSDictionary *)info; {
    
    NSInteger index = [info[@"index"] integerValue];
    switch (index) {
        case 1:
        {
            //取消
        }
            break;
        case 2:
        {
            //相册
            [WLPhotoModel photoModelObject:theVC
                            withDelegate:objDelegate
                        pickerSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
        case 3:
        {
            //拍照
            [WLPhotoModel photoModelObject:theVC
                            withDelegate:objDelegate
                        pickerSourceType:UIImagePickerControllerSourceTypeCamera];
        }
            break;
            
        default:
            break;
    }
}

@end
