//
//  PhotoModel.h
//  newShop
//
//  Created by scjh on 15/5/20.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface WLPhotoModel : NSObject

+ (void)photoModelActionObjectVC:(id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)theVC
                    withDelegate:(id)objDelegate
                        withInfo:(NSDictionary *)info;

@end
