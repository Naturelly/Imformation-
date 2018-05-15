//
//  TYThirdLoginAction.m
//  informatioanDEMO
//
//  Created by ios on 2018/5/15.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "TYThirdLoginAction.h"
@implementation TYThirdLoginAction

+ (instancetype)sharedInstance {
    
    static TYThirdLoginAction* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[TYThirdLoginAction alloc] init];
    });
    
    return instance;
}
#pragma mark - qq登录
- (void)tyQQLoginWithQQAppId:(NSString *)qqAppId{
 
    _oauth = [[TencentOAuth alloc] initWithAppId:qqAppId andDelegate:self];
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accesstoken = [configDefaults objectForKey:@"accesstoken"];
    if (accesstoken) {
        NSString *accessToken =  [configDefaults objectForKey:@"accesstoken"];
        NSString *openId = [configDefaults objectForKey:@"openID"];
        NSDate *expirationDate = [configDefaults objectForKey:@"expirationDate"];
        [_oauth setAccessToken:accessToken] ;
        [_oauth setOpenId:openId] ;
        [_oauth setExpirationDate:expirationDate] ;
        
    }
    NSArray *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    [_oauth authorize:permissions inSafari:NO];
}

#pragma mark - qq登录数据回调
- (void)tencentDidLogin
{
    NSString *accesstoken = _oauth.accessToken;
    NSString *openID = [_oauth openId] ;
    NSDate *expirationDate = [_oauth expirationDate] ;
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    [configDefaults setObject:accesstoken forKey:@"accesstoken"];
    [configDefaults setObject:openID forKey:@"openID"];
    [configDefaults setObject:expirationDate forKey:@"expirationDate"];
    [configDefaults synchronize];
    [_oauth getUserInfo];
}

#pragma mark - qq登录个人信息
-(void)getUserInfoResponse:(APIResponse *)response{
    NSLog(@"%@",response.jsonResponse);
    _oauth = nil;
}

#pragma mark - 微信登录
- (void)tyWeiXinLoginWithWeiXinAppId:(NSString *)weiXinAppId WeiXinAppSecret:(NSString *)weiXinAppSecret ViewController:(UIViewController *)viewController{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postCode:) name:@"weiXinLoginNotification" object:nil];
    [WXApi registerApp:weiXinAppId];
    self.wxAppSecret = weiXinAppSecret;
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"xxx";
    [WXApi sendAuthReq:req
        viewController:viewController
              delegate:self];
    
}

#pragma mark - 微信登录token判断
- (void)postCode:(NSNotification *)text{
    
    NSString *code = text.userInfo[@"code"];
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *refresh_token = [configDefaults objectForKey:@"refresh_token"];
    if (refresh_token) {
        [self postRefresh_token];
    }else{
        [self getAccess_tokenWithCode:code];
    }
    
}

#pragma mark - 微信登录刷新token
- (void)postRefresh_token{
    //f1064141625c4d558485e5c84709b02f   728640db2e9924598ba219fcd6396c4f   wxea2870567cabc82f   wx002d6538f5046519
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *refresh_token = [configDefaults objectForKey:@"refresh_token"];
    
    NSString *nsurlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",@"wxea2870567cabc82f",refresh_token];
    NSURL *nsurl = [NSURL URLWithString:nsurlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 超时时间
    config.timeoutIntervalForRequest = 10.0;
    config.timeoutIntervalForResource = 60.0;
    // 是否允许使用蜂窝网络(后台传输不适用)
    config.allowsCellularAccess = YES;
    config.HTTPMaximumConnectionsPerHost = 1;
    //设置请求类型
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        //                                                        [IMMWProgressHUD hideHUD];
                                                    });
                                                    if (error) { //请求失败
                                                        //                                                        failureBlock(error);
                                                    } else {  //请求成功
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            //{"access_token":"9_65PLb0tjvx3WpBJuomz16THbZ4DiCFm2rXgMwwwwK-R-trXPUg2y1HM9OaC83uwYMjSUdMRey-tg8qlpa20gUVBBoz6LPg_jsKhUBRqq26A","expires_in":7200,"refresh_token":"9_3ZYJJuZ8DJzaxRUCnZKCak9DEWUF2FtjwlnMr5EfECttFeBKFzemGeQ40VhVoAlOY_VQIcBJrFXmyoWm4j2gkO31rrZgxcEw-9vs9FyXrg4","openid":"oHqr5v5blW8xcRWSEn2M9dok9mXM","scope":"snsapi_userinfo","unionid":"oVaINuIky77MvVrHkONDVmgdKGII"}
                                                            NSString *decryptData = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                                                            //                                                            DLog(@"返回----%@",decryptData);
                                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[decryptData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                                                            NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
                                                            [configDefaults setObject:dic[@"refresh_token"] forKey:@"refresh_token"];
                                                            [configDefaults setObject:dic[@"access_token"] forKey:@"access_token"];
                                                            [configDefaults setObject:dic[@"openid"] forKey:@"openid"];
                                                            [configDefaults synchronize];
                                                            [self postLogin];
                                                            //                                                            successBlock(dic);
                                                        });
                                                        
                                                    }
                                                }];
    [dataTask resume];  //开始请求
}

#pragma mark - 微信登录获取token
- (void)getAccess_tokenWithCode:(NSString *)code{
    //f1064141625c4d558485e5c84709b02f   728640db2e9924598ba219fcd6396c4f   wxea2870567cabc82f   wx002d6538f5046519
    NSString *nsurlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wxea2870567cabc82f",self.wxAppSecret,code];
    NSURL *nsurl = [NSURL URLWithString:nsurlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 超时时间
    config.timeoutIntervalForRequest = 10.0;
    config.timeoutIntervalForResource = 60.0;
    // 是否允许使用蜂窝网络(后台传输不适用)
    config.allowsCellularAccess = YES;
    config.HTTPMaximumConnectionsPerHost = 1;
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        //                                                        [IMMWProgressHUD hideHUD];
                                                    });
                                                    if (error) { //请求失败
                                                        //                                                        failureBlock(error);
                                                    } else {  //请求成功
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            //{"access_token":"9_65PLb0tjvx3WpBJuomz16THbZ4DiCFm2rXgMwwwwK-R-trXPUg2y1HM9OaC83uwYMjSUdMRey-tg8qlpa20gUVBBoz6LPg_jsKhUBRqq26A","expires_in":7200,"refresh_token":"9_3ZYJJuZ8DJzaxRUCnZKCak9DEWUF2FtjwlnMr5EfECttFeBKFzemGeQ40VhVoAlOY_VQIcBJrFXmyoWm4j2gkO31rrZgxcEw-9vs9FyXrg4","openid":"oHqr5v5blW8xcRWSEn2M9dok9mXM","scope":"snsapi_userinfo","unionid":"oVaINuIky77MvVrHkONDVmgdKGII"}
                                                            NSString *decryptData = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                                                            //                                                            DLog(@"返回----%@",decryptData);
                                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[decryptData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                                                            
                                                            NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
                                                            [configDefaults setObject:dic[@"refresh_token"] forKey:@"refresh_token"];
                                                            [configDefaults setObject:dic[@"access_token"] forKey:@"access_token"];
                                                            [configDefaults setObject:dic[@"openid"] forKey:@"openid"];
                                                            [configDefaults synchronize];
                                                            [self postLogin];
                                                            //                                                            successBlock(dic);
                                                        });
                                                        
                                                    }
                                                }];
    [dataTask resume];  //开始请求
}

#pragma mark - 微信登录获得code
- (void)postLogin{
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [configDefaults objectForKey:@"access_token"];
    NSString *openId = [configDefaults objectForKey:@"openid"];
    //f1064141625c4d558485e5c84709b02f   728640db2e9924598ba219fcd6396c4f   wxea2870567cabc82f   wx002d6538f5046519
    NSString *nsurlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openId];
    NSURL *nsurl = [NSURL URLWithString:nsurlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 超时时间
    config.timeoutIntervalForRequest = 10.0;
    config.timeoutIntervalForResource = 60.0;
    // 是否允许使用蜂窝网络(后台传输不适用)
    config.allowsCellularAccess = YES;
    config.HTTPMaximumConnectionsPerHost = 1;
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        //                                                        [IMMWProgressHUD hideHUD];
                                                    });
                                                    if (error) { //请求失败
                                                        //                                                        failureBlock(error);
                                                    } else {  //请求成功
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            //{"access_token":"9_65PLb0tjvx3WpBJuomz16THbZ4DiCFm2rXgMwwwwK-R-trXPUg2y1HM9OaC83uwYMjSUdMRey-tg8qlpa20gUVBBoz6LPg_jsKhUBRqq26A","expires_in":7200,"refresh_token":"9_3ZYJJuZ8DJzaxRUCnZKCak9DEWUF2FtjwlnMr5EfECttFeBKFzemGeQ40VhVoAlOY_VQIcBJrFXmyoWm4j2gkO31rrZgxcEw-9vs9FyXrg4","openid":"oHqr5v5blW8xcRWSEn2M9dok9mXM","scope":"snsapi_userinfo","unionid":"oVaINuIky77MvVrHkONDVmgdKGII"}
                                                            NSString *decryptData = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                                                            //                                                            DLog(@"返回----%@",decryptData);
                                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[decryptData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                                                            
                                                            NSLog(@"%@",dic);
                                                            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiXinLoginNotification" object:nil];
                                                            self.wxAppSecret = nil;
                                                            //                                                            successBlock(dic);
                                                        });
                                                        
                                                    }
                                                }];
    [dataTask resume];  //开始请求
}

#pragma mark - 微博登录
- (void)tyWeiBoLoginWithWeiBoAppKey:(NSString *)weiBoAppKey WeiBoAppRedirect:(NSString *)weiBoAppRedirect{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboLoginByResponse:) name:@"weiBoLoginNotification" object:nil];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:weiBoAppKey];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = weiBoAppRedirect;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    //    [self logoutSuccessed];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://172.16.0.11/js/123.html"]];
    
}

#pragma mark - 微博access_token
-(void)weiboLoginByResponse:(NSNotification *)requestUserInfo{
    
    NSLog(@"userinfo %@",requestUserInfo.userInfo);
    NSMutableDictionary * param = [[NSMutableDictionary alloc]initWithCapacity:2];
    [param setObject:requestUserInfo.userInfo[@"access_token"] forKey:@"access_token"];
    [param setObject:requestUserInfo.userInfo[@"uid"] forKey:@"uid"];
    NSString * userInfoUrl = @"https://api.weibo.com/2/users/show.json";
    [WBHttpRequest requestWithAccessToken:requestUserInfo.userInfo[@"access_token"] url:userInfoUrl httpMethod:@"GET" params:param delegate:self withTag:@"userInfo"];
    
}

#pragma mark - 微博个人信息
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    //此处不需要使用导入第三方SBJson去解析data也可以
    id d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary * dict =  (NSDictionary *)d;
    NSLog(@"dict:%@",dict);
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notificationLogin" object:nil];
}

@end
