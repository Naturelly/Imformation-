//
//  MWSDKImformation.h
//  Imformation
//
//  Created by ios on 2018/4/28.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TyProductsRequestSuccessBlock)(void);
@protocol IMImformationActionDelegate <NSObject>
@end
@interface IMImformationAction : NSObject
@property (nonatomic,copy)TyProductsRequestSuccessBlock block;
//获取单例
+ (instancetype)sharedInstance ;

- (NSDictionary *)getImformationForTestWithAppId:(NSString *)appId;

//- (void)getImformation;

//发送手机信息
- (void)postImformationWithAppId:(NSString *)appId AndUrlStr:(NSString *)urlStr;
@end
