//
//  AppDelegate.m
//  MobADDemo
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 Max. All rights reserved.
//

#import "AppDelegate.h"
//#import <MOBFoundation/MOBFoundation.h>
#import <FCommon/FCommon.h>
#import <MobAD/MobAD.h>
#import "Const.h"
#import "LaunchViewController.h"
#import "MobADTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *str = @"sss";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    // 监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_appNetworkReachabilityChanged:)
                                                 name:kFCMNReachabilityChangedNotification
                                               object:nil];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window = window;
    window.backgroundColor = [UIColor whiteColor];
    LaunchViewController *launchVC = [[LaunchViewController alloc] init];
    window.rootViewController = launchVC;
    // 启动展示开屏广告
    [MobAD showSplashAdWithPlacementId:kSSplashPID
                                onView:self.window
                               adFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8)
                        viewController:launchVC
                        customSkipView:nil
                      customBottomView:nil
                       tolerateTimeout:5
                    adLifeTimeCallback:^(NSInteger lifeTime) {
        NSLog(@"=====> splash ad life time: %zd <=====", lifeTime);
    }
                          stateChanged:^(id adObject, MADState state, NSError *error) {
        NSLog(@"----> state: %lu  error:%@", (unsigned long)state, error.localizedDescription);
        if (state == MADStateDidLoad) {
            [launchVC dismissSplashHUD];
        }
        
        if (state == MADStateWillClose || state == MADStateDidClose) {
            
            MobADTabBarController *tabVC = [[MobADTabBarController alloc] init];
            window.rootViewController = tabVC;
        }
        if (error) {
            
            MobADTabBarController *tabVC = [[MobADTabBarController alloc] init];
            window.rootViewController = tabVC;
        }
    }];
    //    }];
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)_appNetworkReachabilityChanged:(NSNotification *)note
{
    FCMNNetworkType netStatus = [FCMNDevice currentNetworkType];
    // 网络变化时如果本地配置信息为空则请求配置信息
    NSString *info = netStatus != FCMNNetworkTypeNone ? @"网络链接成功！！" : @"网络链接断开, 请重新连接网络！！";
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:info preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
}


#pragma mark - private

- (void)_showErrorAlert:(NSError *)error
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"错误信息" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [self.window.rootViewController presentViewController:alertC animated:YES completion:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
