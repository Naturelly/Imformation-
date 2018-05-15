//
//  TYMobilModel.h
//  Imformation
//
//  Created by ios on 2018/5/3.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMTYMobilModel : NSObject

//获取单例
+ (instancetype)sharedInstance ;

//手机类型
- (NSString*)iphoneType;

@end
