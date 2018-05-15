//
//  NSURLSessionRequestTool.h
//  PaymentSDK
//
//  Created by JunL on 2017/3/13.
//  Copyright © 2017年 Mac . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletioBlock)(NSDictionary *dic, NSURLResponse *response, NSError *error);
typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^SuccessStringBlock)(NSString *responseStr);
typedef void (^FailureBlock)(NSError *error);


@interface IMMWNetworkingUtil : NSObject



/**
 * post请求
 */
+ (void)postWithUrlString:(NSString *)url
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock;



@end
