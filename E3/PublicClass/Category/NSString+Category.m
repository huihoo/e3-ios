//
//  NSString+MKNetworkKitAdditions.m
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


#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (NSStringCategory)
//资源文件读取
+ (UIImage *)GLimageNamed:(NSString *)name
{
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && name ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : name];
        
        if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 || [[UIScreen mainScreen] scale] == 2.0 ) {
            // NSLog(@"scale=2");
            return  [UIImage imageWithCGImage:[[UIImage  imageWithContentsOfFile:s] CGImage]
                                        scale:2.0 orientation:UIImageOrientationUp];
        }
        return [UIImage imageWithContentsOfFile:s];
    }
    
    return nil;
    
}

//MD5 加密
+(NSString*)md5Str:(NSString*)str
{
    NSString *md5str;
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    md5str =  [hash lowercaseString];
    return md5str;
}

//颜色#XXXXX
+ (UIColor *)colorWithString:(NSString*)colorString alpha:(CGFloat)alpha{
    NSString *hexColor = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([hexColor length] < 6) {
        return [UIColor blackColor];
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    if ([hexColor length] != 6 && [hexColor length] != 8) {
        return [UIColor blackColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [hexColor substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    range.location = 6;
    NSString *aString = @"FF";
    if ([hexColor length] == 8) {
        aString = [hexColor substringWithRange:range];
    }
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}


//文本先进行DES加密。然后再转成base64
+ (NSString *)base64StringFromText:(NSString *)text withKey:(NSString*)key
{
    if (text && ![text isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin
        data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return @"";
    }
}

//先把base64转为文本。然后再DES解密
+ (NSString *)textFromBase64String:(NSString *)base64 withKey:(NSString*)key
{
    if (base64 && ![base64 isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:base64];
        //IOS 自带DES解密 Begin
        data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}


/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : + (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
	if (string == nil)
		[NSException raise:NSInvalidArgumentException format:nil];
	if ([string length] == 0)
		return [NSData data];
	
	static char *decodingTable = NULL;
	if (decodingTable == NULL)
	{
		decodingTable = malloc(256);
		if (decodingTable == NULL)
			return nil;
		memset(decodingTable, CHAR_MAX, 256);
		NSUInteger i;
		for (i = 0; i < 64; i++)
			decodingTable[(short)encodingTable[i]] = i;
	}
	
	const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
	if (characters == NULL)     //  Not an ASCII string!
		return nil;
	char *bytes = malloc((([string length] + 3) / 4) * 3);
	if (bytes == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (YES)
	{
		char buffer[4];
		short bufferLength;
		for (bufferLength = 0; bufferLength < 4; i++)
		{
			if (characters[i] == '\0')
				break;
			if (isspace(characters[i]) || characters[i] == '=')
				continue;
			buffer[bufferLength] = decodingTable[(short)characters[i]];
			if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
			{
				free(bytes);
				return nil;
			}
		}
		
		if (bufferLength == 0)
			break;
		if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
		{
			free(bytes);
			return nil;
		}
		
		//  Decode the characters in the buffer to bytes.
		bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
		if (bufferLength > 2)
			bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
		if (bufferLength > 3)
			bytes[length++] = (buffer[2] << 6) | buffer[3];
	}
	
	bytes = realloc(bytes, length);
	return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : + (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
	if ([data length] == 0)
		return @"";
	
    char *characters = malloc((([data length] + 2) / 3) * 4);
	if (characters == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (i < [data length])
	{
		char buffer[3] = {0,0,0};
		short bufferLength = 0;
		while (bufferLength < 3 && i < [data length])
			buffer[bufferLength++] = ((char *)[data bytes])[i++];
		
		//  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
		characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		if (bufferLength > 1)
			characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else characters[length++] = '=';
		if (bufferLength > 2)
			characters[length++] = encodingTable[buffer[2] & 0x3F];
		else characters[length++] = '=';
	}
	
	return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}


/**
 字节数组转化16进制数
 */
+(NSString *) parseByteArray2HexString:(Byte[]) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
//    NSLog(@"bytes 的16进制数为:%@",hexStr);
    return [hexStr uppercaseString];
}


/*
 将16进制数据转化成NSData 数组
 */
+(NSData*) parseHexToByteArray:(NSString*) hexString
{
    int j=0;
    Byte bytes[hexString.length];
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
//    NSLog(@"newData=%@",newData);
    return newData;
}

+ (NSString *)replaceEmptyOrNull:(NSString *)checkString
{
    if (!checkString || [checkString isEqualToString:@""]||[checkString isEqualToString:@"null"]) {
        return @"";
    }
    return checkString;
}

- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];      
}
- (NSString*) sha
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


- (NSString*) uniqueString
{
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);
	NSString	*uuidString = ( NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
	CFRelease(uuidObj);
	return uuidString;
}

- (NSString*) urlEncodedString {
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        ( CFStringRef) self, 
                                                                        nil,
                                                                        CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\|~"),
                                                                        kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge  NSString*) encodedCFString];    

    if(!encodedString)
        encodedString = @"";    
    
    return encodedString;
    
//    NSString *resultStr = self;
//    
//    CFStringRef originalString = (CFStringRef) self;
//    CFStringRef leaveUnescaped = CFSTR(" ");
//    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
//    
//    CFStringRef escapedStr;
//    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                         originalString,
//                                                         leaveUnescaped,
//                                                         forceEscaped,
//                                                         kCFStringEncodingUTF8);
//    
//    if( escapedStr )
//    {
//        NSMutableString *mutableStr = [NSMutableString stringWithString:(NSString *)escapedStr];
//        CFRelease(escapedStr);
//        
//        // replace spaces with plusses
//        [mutableStr replaceOccurrencesOfString:@" "
//                                    withString:@"+"
//                                       options:0
//                                         range:NSMakeRange(0, [mutableStr length])];
//        resultStr = mutableStr;
//    }
//    return resultStr;
//    
//    //http://192.168.1.140:8080/gateway/router?app_key=72c81171a1bfefb5c32b51629a9a60a8&method=org.baihuogou.api.category.first_level.get&timestamp=1399278586&v=v1.0&format=json&sign_method=md5&session_key=e572bc2f46ef88349291d3fa45c81a98&status=THREE&last_update=2014-03-09+23%3A4
}

- (NSString*) urlDecodedString {

    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, 
                                                                                          ( CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge  NSString*) decodedCFString];    
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                          mutabilityOption:NSPropertyListImmutable
                           
                                                                    format:NULL
                           
                                                          errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];  
    
    
    
}


+(RegexType)ValidateUserName:(NSString *)userName withMsg:(NSString *)msg{
    if (userName == nil || [userName isEqualToString:@""]) {
        return isNill;
    }
    //    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{5,16}$";
    NSString *regex = @"^[a-z,A-Z][a-z,A-Z,@,-,0-9]{7,13}$"; // change tianzhu0719
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:userName]) {
        return isRight;
    }else{
        return isError;
    }
}


+(RegexType)isValidateUserName:(NSString *)userName withMsg:(NSString *)msg{
    if (userName == nil || [userName isEqualToString:@""]) {
        return isNill;
    }
    //    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{5,16}$";
    
    NSString *regex = @"^[a-z,A-Z][a-z,A-Z,0-9,_]{1,13}$"; // change tianzhu0719
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:userName]) {
        return isRight;
    }else{
        return isError;
    }
}

+(RegexType)isValidateDigtal:(NSString *)blank{
    if (blank == nil || [blank isEqualToString:@""]) {
        return isNill;
    }
    NSString *regex = @"^\\d{0,10}$"; // change tianzhu0719
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:blank]) {
        return isError;
    }else{
        return isRight;
    }
}
+ (RegexType)isValidateNum:(NSString *)num;
{
    if (num == nil || [num isEqualToString:@""] || [num isEqual:[NSNull null]]) {
        return isNill;
    }
    NSString *regex = @"^[0-9]+(.[0-9]{1,2})?$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:num]) {
        return isRight;
    }else{
        return isError;
    }
}
+(RegexType)ValidatePsw:(NSString *)psw withMsg:(NSString *)msg{
    if (psw == nil || [psw isEqualToString:@""]) {
        return isNill;
    }
    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{6,14}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:psw]) {
        return isRight;
    }else{
        
        return isError;
    }
    
}
+(RegexType)ValidateSearchText:(NSString *)searchText
{
    if (searchText == nil || [searchText isEqualToString:@""]) {
        return isNill;
    }
    NSString *regex = @"[\u4e00-\u9fa5_a-zA-Z0-9_]{1,20}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:searchText]) {
        return isRight;
    }else{
        return isError;
    }
}

+(RegexType)ValidateTotalString:(NSString *)string
{
    if (string == nil || [string isEqualToString:@""]) {
        return isNill;
    }
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:string]) {
        return isRight;
    }else{
        return isError;
    }
}
+(RegexType)ValidateNickName:(NSString *)nickName withMsg:(NSString *)msg{
    if (nickName == nil || [nickName isEqualToString:@""]) {
        return isNill;
    }
    //    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{5,16}$";
    NSString *regex = @"^[a-z,A-Z,/\u4e00-\u9fa5][a-z,A-Z,@,-,0-9,/\u4e00-\u9fa5]{1,6}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:nickName]) {
        return isRight;
    }else{
        return isError;
    }
}

+(RegexType)ValidateUserNameDefault:(NSString *)userName withMsg:(NSString *)msg
{
    if (userName == nil || [userName isEqualToString:@""]) {
        return isNill;
    }
    //    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{5,16}$";
    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{8,14}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:userName]) {
        return isRight;
    }else{
        return isError;
    }
}
#pragma mark validateEmail
+ (RegexType) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	if ([emailTest evaluateWithObject:candidate]) {
        return isRight;
    }else{
        return isError;
    }
}
#pragma mark validateTel
+ (RegexType) validateTel: (NSString *) candidate {
    NSString *telRegex = @"^1[358]\\d{9}$";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
	if ([telTest evaluateWithObject:candidate]) {
        return isRight;
    }else{
        return isError;
    }
}
#pragma mark character  //限制输入汉子或字母
+(RegexType) validateCharacter:(NSString *)candidate{
    NSString *characterRegex=@"^[\u4E00-\u9FA5A-Za-z_]+$";
    NSPredicate *characterTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",characterRegex];
    if ([characterTest evaluateWithObject:candidate]) {
        return isRight;
    }else{
        return isError;
    }
}
+ (RegexType) validateCharacternum:(NSString *)candidate;{
    NSString *characterRegex=@"^[-\u4E00-\u9FA5A-Za-z-\\d-]+$";
    NSPredicate *characterTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",characterRegex];
    if ([characterTest evaluateWithObject:candidate]) {
        return isRight;
    }else{
        return isError;
    }
}
+ (RegexType)validateNumeric:(NSString *)str
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:str]) {
        return isRight;
    }else{
        return isError;
    }
}

+(RegexType)isValidateUserNameDefault:(NSString *)userName withMsg:(NSString *)msg
{
    if (userName == nil || [userName isEqualToString:@""]) {
        return isNill;
    }
    //    NSString *regex = @"^[a-z,A-Z,@,-,0-9]{5,16}$";
    NSString *regex = @"^[a-z,A-Z][a-z,A-Z,0-9,_]{7,13}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:userName]) {
        return isRight;
    }else{
        return isError;
    }
}

+(RegexType)isValidatePsw:(NSString *)psw withMsg:(NSString *)msg{
    if (psw == nil || [psw isEqualToString:@""]) {
        return isNill;
    }
    NSString *regex = @"^[a-z,A-Z,0-9][a-z,A-Z,0-9,_]{1,13}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:psw]) {
        return isRight;
    }else{
        
        return isError;
    }
    
}
+(RegexType)isValidateBlank:(NSString*)blank{
    if (blank == nil || [blank isEqualToString:@""]) {
        return isNill;
    }
    NSString *regex = @"\\s";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([test evaluateWithObject:blank]) {
        return isRight;
    }else{
        
        return isError;
    }
}
@end