//
//  SDKAccount.h
//  demo22
//
//  Created by xj on 2017/5/10.
//  Copyright © 2017年 xj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TyProductsRequestSuccessBlock)(void);

@interface IMImformationTotal : NSObject
@property (nonatomic,copy)TyProductsRequestSuccessBlock block;
//获取单例
+ (instancetype)sharedInstance;

- (NSDictionary *)getImformationForTestWithAppId:(NSString *)appId;

//- (void)getImformation;

//发送手机信息
//appId为渠道号，urlStr为请求接口
//第一次调用appId需要传值，之后的可以从NSUserDefaults中IMImformationAppId字段取
-(void)postImformationWithAppId:(NSString *)appId AndUrlStr:(NSString *)urlStr;

//QQ登录
- (void)tyQQLoginWithQQAppId:(NSString *)qqAppId;

//微信登录
- (void)tyWeiXinLoginWithWeiXinAppId:(NSString *)weiXinAppId WeiXinAppSecret:(NSString *)weiXinAppSecret ViewController:(UIViewController *)viewController;

//微博登录
- (void)tyWeiBoLoginWithWeiBoAppKey:(NSString *)weiBoAppKey WeiBoAppRedirect:(NSString *)weiBoAppRedirect;

@end
