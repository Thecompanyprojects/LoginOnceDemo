//
//  AppDelegate.h
//  LoginDemo
//
//  Created by 王俊钢 on 2021/10/27.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
@property (nonatomic, strong) UIWindow *window;
@end

