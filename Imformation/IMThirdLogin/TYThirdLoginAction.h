//
//  TYThirdLoginAction.h
//  informatioanDEMO
//
//  Created by ios on 2018/5/15.
//  Copyright © 2018年 ios. All rights reserved.
//
#import "WeiboSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "TencentOAuth.h"
#import <Foundation/Foundation.h>

@interface TYThirdLoginAction : NSObject<TencentSessionDelegate,WXApiDelegate,WeiboSDKDelegate,WBHttpRequestDelegate,TencentLoginDelegate>

//单例
+ (instancetype)sharedInstance ;

//QQ登录
- (void)tyQQLoginWithQQAppId:(NSString *)qqAppId;

//微信登录
- (void)tyWeiXinLoginWithWeiXinAppId:(NSString *)weiXinAppId WeiXinAppSecret:(NSString *)weiXinAppSecret ViewController:(UIViewController *)viewController;

//微博登录
- (void)tyWeiBoLoginWithWeiBoAppKey:(NSString *)weiBoAppKey WeiBoAppRedirect:(NSString *)weiBoAppRedirect;

@property (nonatomic, retain)TencentOAuth *oauth;

@property (nonatomic, strong)NSString *wxAppSecret;

@end
