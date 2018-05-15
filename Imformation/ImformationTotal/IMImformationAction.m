//
//  MWSDKImformation.m
//  Imformation
//
//  Created by ios on 2018/4/28.
//  Copyright © 2018年 ios. All rights reserved.
//
#import "IMMWNetworkingUtil.h"
#import "IMImformationAction.h"
#import "IMiPhoneImformation.h"
#import "IMMWBaseMacro.h"
@implementation IMImformationAction
+ (instancetype)sharedInstance {
    
    static IMImformationAction* instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[IMImformationAction alloc] init];
    });
    
    return instance;
}
- (NSDictionary *)getImformationForTestWithAppId:(NSString *)appId{
    
    NSDictionary * imfoDic = [self getImformationForTestLiftWithAppId:appId];
    NSLog(@"2,%@",imfoDic);
    
    return imfoDic;
}
#pragma mark-发送手机信息
-(void)postImformationWithAppId:(NSString *)appId AndUrlStr:(NSString *)urlStr{
    
    NSDictionary * imfoDic = [self getImformationForTestLiftWithAppId:appId];
    DLog(@"发送数据");
//    NSDictionary *infoDic = @{@"appid":appId};
    NSLog(@"3,%@",imfoDic);
    [IMMWNetworkingUtil postWithUrlString:urlStr parameters:imfoDic success:^(NSDictionary *data) {
        DLog(@"发送成功");
        DLog(@"%@",data);
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            if ([[data allKeys] containsObject:@"ChannelID"]) {
                DLog(@"YES11");
                NSString *channelID = [NSString stringWithFormat:@"%@",data[@"ChannelID"]];
                NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
                    
                NSString *ChannelID = [configDefaults objectForKey:@"ChannelID"];
                    
                if (![ChannelID isEqualToString:channelID]) {
                        
                    DLog(@"成功添加本地");
                    [configDefaults setObject:channelID forKey:@"ChannelID"];
                    [configDefaults synchronize];
                        
                    if (self.block) {
                        self.block();
                    }
                        
                }
            }
        }
        
    } failure:^(NSError *error) {
        
        DLog(@"发送失败");
        DLog(@"%@",error);
        
    }];
    
}
- (NSDictionary *)getImformationForTestLiftWithAppId:(NSString *)appId{
    
    IMiPhoneImformation *iPhoneImformations = [IMiPhoneImformation sharedInstance];
    
    //data.systemType 是 string 系统类型（Android/iPhone/iPad/Windows）
    NSString *systemType = [iPhoneImformations getSystemType];
    
    //data.model 是 string 手机型号
    NSString *model = [iPhoneImformations getModel];
    
    //data.version 是 string 系统版本（Android：4.0;IOS :10）
    NSString *version = [iPhoneImformations getVersion];
    
    //data.withinIp 是 string 内网IP
    NSString *withinIp= [iPhoneImformations getWithinIp];
   
    //data.abroadIp 是 string 外网IP
    NSString *abroadIp= [iPhoneImformations getAbroadIp];
    
    //data.height 是 int 屏幕高度
    NSNumber *height = [NSNumber numberWithInteger:[iPhoneImformations getHeight]];
    
    //data.width 是 int 屏幕宽度
    NSNumber *width = [NSNumber numberWithInteger:[iPhoneImformations getWidth]];
    
    //data.dpi 是 int 屏幕dpi
    NSNumber *dpi = [NSNumber numberWithInteger:[iPhoneImformations getDpi]];
    
    //data.displaySupplier 是 string 显卡渲染器
    NSString *displaySupplier = [iPhoneImformations getDisplaySupplier];
    
    //data.renderer 是 string 显卡供应商
    NSString *renderer = [iPhoneImformations getRenderer];
    
    //data.UUID 是 string ios : UUID; Android : AndroidId
    NSString *UUID = [iPhoneImformations getUUID];
    
    //data.prisonBreak 是 int ios : 1：越狱 2：未越狱 ; Android：0
    NSNumber *prisonBreak = [NSNumber numberWithInteger:[iPhoneImformations getPrisonBreak]];
    
    //data.disk 是 int 磁盘大小
    NSNumber *disk = [NSNumber numberWithInteger:[iPhoneImformations getDisk]];
    
    //data.cpuCount 是 int cpu数量
    NSNumber *cpuCount = [NSNumber numberWithInteger:[iPhoneImformations getCpuCount]];
    
    //data.hardware 是 string ios : 0; Android : 硬件序列
    NSString *hardware = [iPhoneImformations getHardware];
    
    //token.appid 是 int app的唯一标记
    //判断是否存有渠道号
    NSUserDefaults *configDefaults = [NSUserDefaults standardUserDefaults];
    NSString *channelID = [configDefaults objectForKey:@"ChannelID"];
    NSDictionary *infoDic;
    if (channelID.length>0) {
        infoDic = @{@"systemType":systemType,@"model":model,@"version":version,@"withinIp":withinIp,@"abroadIp":abroadIp,@"height":height,@"width":width,@"dpi":dpi,@"displaySupplier":displaySupplier,@"renderer":renderer,@"UUID":UUID,@"prisonBreak":prisonBreak,@"disk":disk,@"cpuCount":cpuCount,@"hardware":hardware,@"appid":appId,@"ChannelID":channelID};
    }else{
        infoDic = @{@"systemType":systemType,@"model":model,@"version":version,@"withinIp":withinIp,@"abroadIp":abroadIp,@"height":height,@"width":width,@"dpi":dpi,@"displaySupplier":displaySupplier,@"renderer":renderer,@"UUID":UUID,@"prisonBreak":prisonBreak,@"disk":disk,@"cpuCount":cpuCount,@"hardware":hardware,@"appid":appId};
    }
    NSLog(@"3,%@",infoDic);
    
    return infoDic;
}
@end
