//
//  IMMWTool.m
//  xuanfuqiu
//
//  Created by xj on 2017/5/19.
//  Copyright © 2017年 xj. All rights reserved.
//

#import "IMMWTool.h"
#import <AssetsLibrary/AssetsLibrary.h>

//获取屏幕 宽度、高度
#define MWSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define MWSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation IMMWTool

+(UIDeviceOrientation)getCurrentDeviceOrientation{
    return [UIDevice currentDevice].orientation;
}

+ (CGFloat)viewX {
    return MWSCREEN_WIDTH/2 - [self viewWidth]/2;
}


+ (CGFloat)viewY:(CGFloat)height {
    return MWSCREEN_HEIGHT/2-height/2;
}

+ (CGFloat)viewWidth {
    
    CGFloat width;
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == 1 || [[UIApplication sharedApplication] statusBarOrientation] == 2) {
        width = MWSCREEN_WIDTH * 0.9f;
        
    }else {
        width = MWSCREEN_WIDTH * 0.55f;
    }
    return width;
}
+ (NSInteger)viewHeight:(CGFloat)height {
    return height;
}


+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


+ (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}
+ (void)alertView:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)alertView:(NSString *)title withMsg:(NSString *)str {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:str delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+(NSString *)getNowTimeTimestamp3{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeSp = [dateFormatter stringFromDate:[NSDate date]];
    return timeSp;
    
}


+ (NSString *)postRequst:(NSDictionary *)rawParams{
    NSArray *keyArr = rawParams.allKeys;
    NSArray *sortKeyArr = [keyArr sortedArrayUsingSelector:@selector(compare:)];
    NSString *urlStr;
    for (int i = 0; i<sortKeyArr.count; i++) {
        NSString *k = sortKeyArr[i];
        NSString *v = [rawParams objectForKey:sortKeyArr[i]];
        NSString *str = [NSString stringWithFormat:@"%@=%@",k,v];
        if (i == 0) {
            urlStr = str;
        }else{
            urlStr = [NSString stringWithFormat:@"%@&%@",urlStr,str];
        }
    }
    return urlStr;
}

+ (void)setLabelColorLab:(UILabel *)lab labAttributedString:(NSString *)attributedStr rangeStr:(NSString *)rangeStr{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:attributedStr];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:rangeStr].location, [[noteStr string] rangeOfString:rangeStr].length);
    //需要设置的位置
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    
    //设置颜色
    [lab setAttributedText:noteStr];
}


+(UIImage *)captureImageFromView:(UIView *)view
{
    CGRect screenRect = [view bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+(void)savePhoto:(UIView *)view
{
    UIImage * image = [self captureImageFromView:view];
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
}


@end
