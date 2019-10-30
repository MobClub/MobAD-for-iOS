//
//  AppDelegate.m
//  MobADDemo
//
//  Created by Max on 2019/7/30.
//  Copyright © 2019 Max. All rights reserved.
//

#import "AppDelegate.h"
#import <MOBFoundation/MOBFoundation.h>
#import "MainViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 监听网络变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_appNetworkReachabilityChanged:)
                                                 name:kMOBFReachabilityChangedNotification
                                               object:nil];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    window.rootViewController = nav;
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)_appNetworkReachabilityChanged:(NSNotification *)note
{
    MOBFNetworkType netStatus = [MOBFDevice currentNetworkType];
    // 网络变化时如果本地配置信息为空则请求配置信息
    NSString *info = netStatus != MOBFNetworkTypeNone ? @"网络链接成功！！" : @"网络链接断开, 请重新连接网络！！";
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:info preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:alertOKAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:nil];
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
