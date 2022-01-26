//
//  AppDelegate.m
//  LoginDemo
//
//  Created by 王俊钢 on 2021/10/27.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "PNSHttpsManager.h"
#import <ATAuthSDK/ATAuthSDK.h>


@interface AppDelegate ()

@end

#define PNSATAUTHSDKINFOKEY @"ATAuthSDKInfoKey"
#define PNSATAUTHSDKINFO  @"MUhmLW8br7EW5KHFkCB2mDZfBXIIt6rNriFxQjR3rMuoD5PUMmPVOeqq0hOgrcIRT8ch8bCFf4iHih29gh6KQYM5OqZ9QOlWB/n7Nb4BpdkOAWCWY2m3FBsZ4YpVVsG69Kb5IDpjM4qJSPBn5O4phWpEc4DFqZomrh1If5VbPt8x5dVA+yS37zCRkDC9CFcE+OIa2+qokc0FSSxyjPU4osveWRkaiQAbG2BKklNDJ6JyjsJRbyWchEmEpbXgPlQbhtTtak7UkagOgvCV10PBUA=="


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HomeViewController *controller = [[HomeViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
   
    
    //[WXApi registerApp:@"wxacf38ed56c932c25" universalLink:@""];

    [WXApi registerApp:@"wxacf38ed56c932c25"];

    NSString *authSDKInfo = [[NSUserDefaults standardUserDefaults] objectForKey:PNSATAUTHSDKINFOKEY];
    if (!authSDKInfo || authSDKInfo.length == 0) {
        authSDKInfo = PNSATAUTHSDKINFO;
    }
    [PNSHttpsManager requestATAuthSDKInfo:^(BOOL isSuccess, NSString * _Nonnull authSDKInfo) {
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:authSDKInfo forKey:PNSATAUTHSDKINFOKEY];
        }
    }];
    [[TXCommonHandler sharedInstance] setAuthSDKInfo:authSDKInfo
                                            complete:^(NSDictionary * _Nonnull resultDic) {
        NSLog(@"设置秘钥结果：%@", resultDic);
    }];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *url = userActivity.webpageURL;
        NSString *str = [NSString stringWithFormat:@"%@",url];
        NSLog(@"%@",str);
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options{
    //处理回调
    if([url.host isEqualToString:@"platformId=wechat"] || [url.host isEqualToString:@"oauth"]){//微信WeChat分享回调
        BOOL isSuccess=[WXApi handleOpenURL:url delegate:self];
        if (isSuccess) {
            
        }else{
           [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinAuth" object:@"0"];
        }
        return isSuccess;
    }
    return  true;
}

- (void)onResp:(BaseResp*)resp{
    
    if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        SendAuthResp *req = (SendAuthResp *)resp;
        if([req.state isEqualToString:@"wx_oauth_authorization_state"]){//微信授权成功
            if(req.errCode == 0){
                NSLog(@"hbnhgnnnnnnnn%@",req.code);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinAuth" object:req.code];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinAuth" object:@"0"];
            }
        }else{
             [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinAuth" object:@"0"];
        }
     }
    
     if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *req = (SendMessageToWXResp *)resp;
        if(req.errCode == 0){
            
        }else{
             
        }
    }
//    //QQ分享后
//    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
//
//        SendMessageToQQResp* sendReq = (SendMessageToQQResp*)resp;
//        // sendReq.result->0分享成功 -4取消分享
//        if ([sendReq.result integerValue] == 0) {
//            NSLog(@"qq share success");
//        }else{
//            NSLog(@"qq share failed");
//        }
//    }
}


@end
