//
//  NSString+MKNetworkKitAdditions.h
//  MKNetworkKitDemo
//
//  Created by Mugunth Kumar (@mugunthkumar) on 11/11/11.
//  Copyright (C) 2011-2020 by Steinlogic Consulting and Training Pte Ltd

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
/*
 
 后面验证需拓展.  部分可适用本项目
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (NSStringCategory)
typedef enum RegexType{
    isNill,
    isError,
    isRight
}RegexType;

//typedef enum {
//    imageSmallType,
//    imageMiddlType,
//    imageBigType,
//}imageType;

//-(NSString*)replaceControlString;
//-(NSString*)imagePathType:(imageType)__type;
//- (NSString *)indentLength:(CGFloat)_len font:(UIFont *)_font;
//- (BOOL)notEmptyOrNull;
//+ (NSString *)replaceEmptyOrNull:(NSString *)checkString;
//-(NSString*)replaceTime;
//-(NSString*)replaceStoreKey;
//- (NSString*)soapMessage:(NSString *)key,...;

#define MYBUNDLE_NAME @"GLResources.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

+ (UIImage *)GLimageNamed:(NSString *)name;

+ (NSString*)md5Str:(NSString*)str;

+ (UIColor *)colorWithString:(NSString*)colorString alpha:(CGFloat)alpha;

//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key;

//先把base64转为文本。然后再DES解密
+ (NSString *)textFromBase64String:(NSString *)base64 withKey:(NSString*)key;

//文本数据进行DES加密
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;
//文本数据进行DES解密
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

//base64格式字符串转换为文本数据
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

//文本数据转换为base64格式字符串
+ (NSString *)base64EncodedStringFrom:(NSData *)data;

//字节数组转化16进制数
+ (NSString *) parseByteArray2HexString:(Byte[]) bytes;
//将16进制数据转化成NSData 数组
+ (NSData*) parseHexToByteArray:(NSString*) hexString;


//加密   sha  md5
- (NSString*) sha;

- (NSString *) md5;

- (NSString*) uniqueString;
//ios iphone html特殊字符转码  
- (NSString*) urlEncodedString;
- (NSString*) urlDecodedString;
//Unicode转换为汉字r
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
//验证用户名是否是7-13位
+(RegexType)ValidateUserName:(NSString *)userName withMsg:(NSString *)msg;
//验证用户密码
+(RegexType)ValidatePsw:(NSString *)psw withMsg:(NSString *)msg;
//验证用户昵称
+(RegexType)ValidateNickName:(NSString *)nickName withMsg:(NSString *)msg;
+(RegexType)ValidateUserNameDefault:(NSString *)userName withMsg:(NSString *)msg;
//邮箱验证格式
+ (RegexType) validateEmail: (NSString *) candidate;
//电话号码限制
+ (RegexType) validateTel: (NSString *) candidate;
//只能是汉字或字母
+ (RegexType) validateCharacter:(NSString *)candidate;
//限制特殊符号
+ (RegexType) validateCharacternum:(NSString *)candidate;
//验证是否是数字
+ (RegexType)validateNumeric:(NSString *)str;
//不能以下划线开头
+(RegexType)isValidateUserName:(NSString *)userName withMsg:(NSString *)msg;
//验证密码
+(RegexType)isValidateUserNameDefault:(NSString *)userName withMsg:(NSString *)msg;
+(RegexType)isValidatePsw:(NSString *)psw withMsg:(NSString *)msg;
+(RegexType)isValidateBlank:(NSString*)blank;
+(RegexType)isValidateDigtal:(NSString *)blank;


//验证金额
+ (RegexType)isValidateNum:(NSString *)num;

//验证搜索字符串 只能为中文或数字
+(RegexType)ValidateSearchText:(NSString *)searchText;


+(RegexType)ValidateTotalString:(NSString *)string;

@end
