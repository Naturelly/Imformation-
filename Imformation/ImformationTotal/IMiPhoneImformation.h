//
//  iPhoneImformation.h
//  Imformation
//
//  Created by ios on 2018/4/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMiPhoneImformation : NSObject

//获取单例
+ (instancetype)sharedInstance ;

//获取系统类型
- (NSString*)getSystemType;

//获取手机型号
- (NSString*)getModel;

//获取系统版本
- (NSString*)getVersion;

//获取内网IP
- (NSString*)getWithinIp;

//获取外网IP
- (NSString*)getAbroadIp;

//获取屏幕高度
- (NSInteger )getHeight;

//获取屏幕宽度
- (NSInteger )getWidth;

//获取屏幕dpi
- (NSInteger )getDpi;

//获取显卡渲染器
- (NSString*)getDisplaySupplier;

//获取显卡供应商
- (NSString*)getRenderer;

//获取UUID
- (NSString*)getUUID;

//获取越狱
- (NSInteger )getPrisonBreak;

//获取磁盘大小
- (NSInteger )getDisk;

//获取cpu数量
- (NSInteger )getCpuCount;

//获取硬件序列
- (NSString*)getHardware;

//- (int )getAppid;
@end
