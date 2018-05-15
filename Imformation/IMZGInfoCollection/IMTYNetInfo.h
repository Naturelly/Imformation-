//
//  TYNetInfo.h
//  Imformation
//
//  Created by ios on 2018/5/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMTYNetInfo : NSObject

//获取单例
+ (instancetype)sharedInstance ;

//获取内网地址
- (NSString *)getIPAddress:(BOOL)preferIPv4;
//获取具体地址
- (NSDictionary *)getIPAddresses;
//获取外网地址
- (NSString *)getAbroadIp;

@end
