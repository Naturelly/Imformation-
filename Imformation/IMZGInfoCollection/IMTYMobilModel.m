//
//  TYMobilModel.m
//  Imformation
//
//  Created by ios on 2018/5/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "IMTYMobilModel.h"
#import <sys/utsname.h>
@implementation IMTYMobilModel

#pragma mark - init method
+ (instancetype)sharedInstance {
    
    static IMTYMobilModel* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[IMTYMobilModel alloc] init];
    });
    
    return instance;
}

#pragma mark - 获取机型方法
- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone,2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone,3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone,3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone,4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone,4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone,4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone,4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone,5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone,5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone,5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone,5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone,5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone,5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone,6Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone,6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone,6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone,6sPlus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone,SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone,7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone,7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone,7Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone,7Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone,8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone,8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone,8Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone,8Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone,X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone,X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod,Touch1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod,Touch2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod,Touch3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod,Touch4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod,Touch5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad,1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad,2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad,2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad,2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad,2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad,Mini1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad,Mini1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad,Mini1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad,3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad,3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad,3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad,4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad,4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad,4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad,Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad,Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad,Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad,Mini2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad,Mini2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad,Mini2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad,Mini3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad,Mini3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad,Mini3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad,Mini4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad,Mini4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad,Air2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad,Air2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad,Pro9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad,Pro9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad,Pro12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad,Pro12.9";
    
    if([platform isEqualToString:@"iPad6,11"])  return@"iPad,5";
    
    if([platform isEqualToString:@"iPad6,12"])  return@"iPad,5";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone,Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone,Simulator";
    
    return platform;
    
}

@end
