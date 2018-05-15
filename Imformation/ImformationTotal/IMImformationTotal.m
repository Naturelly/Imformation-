//
//  SDKAccount.m
//  demo22
//
//  Created by xj on 2017/5/10.
//  Copyright © 2017年 xj. All rights reserved.
//
#import "TYThirdLoginAction.h"
#import "IMImformationTotal.h"
#import "IMImformationAction.h"
@interface IMImformationTotal ()<IMImformationActionDelegate>


@end
@implementation IMImformationTotal

+ (instancetype)sharedInstance {
    
    static IMImformationTotal* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[IMImformationTotal alloc] init];
    });
    
    return instance;
}
- (NSDictionary *)getImformationForTestWithAppId:(NSString *)appId{
    
    NSDictionary * imfoDic = [[IMImformationAction sharedInstance] getImformationForTestWithAppId:appId];
    NSLog(@"1,%@",imfoDic);
    
    return imfoDic;
}
#pragma mark-发送手机信息
-(void)postImformationWithAppId:(NSString *)appId AndUrlStr:(NSString *)urlStr{
    
   
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *ChannelID = [configDefaults objectForKey:@"IMImformationAppId"];
    
    if (![ChannelID isEqualToString:urlStr]) {
   
    [configDefaults setObject:appId forKey:@"IMImformationAppId"];
    [configDefaults synchronize];
        
    }
    
    [[IMImformationAction sharedInstance] postImformationWithAppId:appId AndUrlStr:urlStr];
    [[IMImformationAction sharedInstance] setBlock:^(void) {
        if (self.block) {
            self.block();
        }
    }];
    
    
}
#pragma mark-QQ登录
- (void)tyQQLoginWithQQAppId:(NSString *)qqAppId{
    [[TYThirdLoginAction sharedInstance] tyQQLoginWithQQAppId:qqAppId];
}

#pragma mark-微信登录
- (void)tyWeiXinLoginWithWeiXinAppId:(NSString *)weiXinAppId WeiXinAppSecret:(NSString *)weiXinAppSecret ViewController:(UIViewController *)viewController{
    [[TYThirdLoginAction sharedInstance] tyWeiXinLoginWithWeiXinAppId:weiXinAppId WeiXinAppSecret:weiXinAppSecret ViewController:viewController];
}

#pragma mark-微博登录
- (void)tyWeiBoLoginWithWeiBoAppKey:(NSString *)weiBoAppKey WeiBoAppRedirect:(NSString *)weiBoAppRedirect{
    [[TYThirdLoginAction sharedInstance] tyWeiBoLoginWithWeiBoAppKey:weiBoAppKey WeiBoAppRedirect:weiBoAppRedirect];
}
@end
