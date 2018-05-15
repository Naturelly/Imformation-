//
//  NSURLSessionRequestTool.m
//  PaymentSDK
//
//  Created by JunL on 2017/3/13.
//  Copyright © 2017年 Mac . All rights reserved.
//

#import "IMMWNetworkingUtil.h"
#import "IMMWProgressHUD+NJ.h"
#import "IMMWBaseMacro.h"

@implementation IMMWNetworkingUtil

+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    NSURL *nsurl = [NSURL URLWithString:url];
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
    
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *productidVid = (NSString *)[configDefaults objectForKey:@"productidVid"];
    [configDefaults synchronize];
    
    [request setValue:productidVid forHTTPHeaderField:@"X-ANFAN-PRODUCTID"];
    [request setValue:@"1" forHTTPHeaderField:@"X-ANFAN-RETAILER"];

    

    
    DLog(@"shuju1-----%@",parameters);
    DLog(@"shuju2-----%@",[self postRequst:parameters]);
    request.HTTPBody = [[self postRequst:parameters] dataUsingEncoding:NSUTF8StringEncoding];
    DLog(@"shuju3-----%@",request.HTTPBody);
//    request.HTTPBody = [[crsa encryptByRsaWithCutData:[self postRequst:parameters] keyType:KeyTypePublic] dataUsingEncoding:NSUTF8StringEncoding];
    [IMMWProgressHUD showMessage:@"正在加载中....."];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [IMMWProgressHUD hideHUD];
                                                    });
                                                    if (error) { //请求失败
                                                        failureBlock(error);
                                                    } else {  //请求成功
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            NSString *decryptData = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                                                            DLog(@"返回----%@",decryptData);
                                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[decryptData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                                                            successBlock(dic);
                                                        });
                                                        
                                                    }
                                                }];
    [dataTask resume];  //开始请求
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
+ (NSString *) postRequst:(NSDictionary *) rawParams{
    NSArray *keyArr = rawParams.allKeys;
    NSArray *sortKeyArr = [keyArr sortedArrayUsingSelector:@selector(compare:)];
    NSString *urlStr;
    for (int i = 0; i<sortKeyArr.count; i++) {
        NSString *k = sortKeyArr[i];
        NSString *v = [rawParams objectForKey:sortKeyArr[i]];
        NSString *str = [NSString stringWithFormat:@"%@=%@",k,v];
        if (i == 0) {
            urlStr = str;
        }else{
            urlStr = [NSString stringWithFormat:@"%@&%@",urlStr,str];
        }
    }
    return urlStr;
}


@end
