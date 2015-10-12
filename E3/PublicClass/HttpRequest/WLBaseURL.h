//
//  WLBaseURL.h
//  E3
//
//  Created by 王亮 on 15/8/17.
//  Copyright (c) 2015年 HuiHoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLBaseURL : NSObject

+(NSString *) getURLStringWithParameters:(NSDictionary *) parmeters;

+(NSDictionary *) postCodeingUrlWithDic:(NSDictionary *) dic;

@end
