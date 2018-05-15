//
//  iPhoneImformation.m
//  Imformation
//
//  Created by ios on 2018/4/28.
//  Copyright © 2018年 ios. All rights reserved.
//
#import <GLKit/GLKit.h>
#import "IMZGInfoCollection.h"
#import "IMiPhoneImformation.h"
#import <UIKit/UIKit.h>

@implementation IMiPhoneImformation

#pragma mark - init method
+ (instancetype)sharedInstance {
    
    static IMiPhoneImformation* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[IMiPhoneImformation alloc] init];
    });
    
    return instance;
}

#pragma mark -  系统类型
-(NSString *)getSystemType{
    
    NSString *systemType = [[UIDevice currentDevice] systemName];
    
    return systemType;
}

#pragma mark -   手机型号
-(NSString *)getModel{
    
    NSString *model = [[IMTYMobilModel sharedInstance] iphoneType];
    
    return model;
}

#pragma mark -  系统版本
-(NSString *)getVersion{
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    return version;
}

#pragma mark -  内网IP
-(NSString *)getWithinIp{
    
    NSString *withinIp = [[IMTYNetInfo sharedInstance] getIPAddress:YES];
    
    return withinIp;
}

#pragma mark -  外网IP
-(NSString *)getAbroadIp{
   
    NSString *abroadIp = [[IMTYNetInfo sharedInstance] getAbroadIp];
    
    return abroadIp;
}

#pragma mark -  屏幕高度
-(NSInteger )getHeight{
    
    NSInteger heightInt = [[NSString stringWithFormat:@"%.2lf",[[IMZGScreenInfo currentScreenInfo] getCurrentScreenHeight]] integerValue];
    
    return heightInt;
}

#pragma mark -  屏幕宽度
-(NSInteger )getWidth{
    
    NSInteger widthInt = [[NSString stringWithFormat:@"%.2lf",[[IMZGScreenInfo currentScreenInfo] getCurrentScreenWith]] integerValue];
    
    return widthInt;
}

#pragma mark -  屏幕dpi
-(NSInteger )getDpi{
    
    NSInteger dpi = [[NSString stringWithFormat:@"%.2lf",[[IMZGScreenInfo currentScreenInfo] getScreenDpi]] integerValue];
    
    return dpi;
}

#pragma mark -  显卡渲染器
-(NSString *)getDisplaySupplier{
    
    EAGLContext *ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:ctx];
    NSString *displaySupplier = [NSString stringWithCString:(const char*)glGetString(GL_VERSION) encoding:NSASCIIStringEncoding];
    
    return displaySupplier;
}

#pragma mark -  显卡供应商
-(NSString *)getRenderer{
    
    EAGLContext *ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:ctx];
    NSString *renderer = (NSString*)[[IMHardcodedDeviceData sharedDeviceData] getGraphicCardName];

    return renderer;
}

#pragma mark -  UUID
-(NSString *)getUUID{
    
    NSString *UUID = [[IMZGDeviceInfo currentDeviceInfo] getUUID];
    
    return UUID;
}

#pragma mark -  越狱
-(NSInteger )getPrisonBreak{
    
    NSInteger prisonBreak;
    if ([IMZGJailBreak isJailBreak]) {
        prisonBreak = 1;
    }else{
        prisonBreak = 0;
    }
    
    return prisonBreak;
}

#pragma mark -  磁盘大小
-(NSInteger )getDisk{
    
    NSInteger disk = [[NSString stringWithFormat:@"%@",[[IMZGStorageInfo storageInfo] getDiskTotalSizeBySizeType:ZGSizeTypeNormalized]] integerValue];
    
    return disk;
}

#pragma mark -  cpu数量
-(NSInteger )getCpuCount{
    
    NSInteger cpuCount = (NSInteger)[NSProcessInfo processInfo].activeProcessorCount ;
    
    return cpuCount;
}

#pragma mark -  硬件序列
-(NSString *)getHardware{
    
    NSString *hardware = @"0";
    
    return hardware;
}

//#pragma mark -  判断APP来源
//-(int )getAppid{
//    int appid = 0;
//    return appid;
//}

@end
