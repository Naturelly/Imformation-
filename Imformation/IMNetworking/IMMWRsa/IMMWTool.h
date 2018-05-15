//
//  IMMWTool.h
//  xuanfuqiu
//
//  Created by xj on 2017/5/19.
//  Copyright © 2017年 xj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "IMMWProgressHUD.h"
@interface IMMWTool : NSObject
+(UIDeviceOrientation)getCurrentDeviceOrientation;
+ (CGFloat)viewX;
+ (CGFloat)viewY:(CGFloat)height;
+ (CGFloat)viewWidth;
+ (NSInteger)viewHeight:(CGFloat)height;
+ (UIViewController *)getCurrentVC;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validateNumber:(NSString*)number;
+ (void)alertView:(NSString *)str;
+ (void)alertView:(NSString *)title withMsg:(NSString *)str;
+(NSString*)getCurrentTimes;
+(NSString *)getNowTimeTimestamp3;
+ (NSString *)postRequst:(NSDictionary *)rawParams;
+ (void)setLabelColorLab:(UILabel *)lab labAttributedString:(NSString *)attributedStr rangeStr:(NSString *)rangeStr;
+(void)savePhoto:(UIView *)view;
@end
