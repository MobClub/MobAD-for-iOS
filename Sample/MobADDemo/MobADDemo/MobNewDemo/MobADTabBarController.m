//
//  MobADTabBarController.m
//  MobADDemo
//
//  Created by Rocker on 2020/5/11.
//  Copyright © 2020 Max. All rights reserved.
//

#import "MobADTabBarController.h"
#import "MobADMainViewController.h"
#import "MobADSettingViewController.h"
#import "MobADToolViewController.h"

//Debug
//#import "MobADDemoBebugSetViewController.h"

@interface MobADTabBarController ()

@end

@implementation MobADTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor whiteColor];
  
    MobADMainViewController *homeVC = [[MobADMainViewController alloc] init];
    [self addChildVC:homeVC title:@"广告" imageMainName:@"ad" NavTitle:@"广告"];
    
//    MobADToolViewController *toolVc = [[MobADToolViewController alloc] init];
//    [self addChildVC:toolVc title:@"工具" imageMainName:@"tool" NavTitle:@"工具"];
    
    MobADSettingViewController *setVc = [[MobADSettingViewController alloc] init];
//    MobADDemoBebugSetViewController *setVc = [[MobADDemoBebugSetViewController alloc] init];

    [self addChildVC:setVc title:@"设置" imageMainName:@"set" NavTitle:@"设置"];
    
    self.tabBar.tintColor = MOB_RGB(0, 154, 158);

    
        
}

/**
 *  创建TabBar子视图控制器
 *
 *  @param childVC 视图控制器
 *  @param title   tabbar标题
 *  @param imageMainName    图片核心名
 *  @param navTitle      导航栏标题
 */
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageMainName:(NSString *)imageMainName NavTitle:(NSString *)navTitle
{
    childVC.tabBarItem.title = title;
    childVC.navigationItem.title = navTitle;
    
    NSString *imageName = [NSString stringWithFormat:@"tab_icon_%@_nor",imageMainName];
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
    NSString *selectedImageName = [NSString stringWithFormat:@"tab_icon_%@_sel",imageMainName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MOB_RGB(144, 164, 174);
    textAttrs[NSFontAttributeName] = PingFangMediumFont(10);
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = MOB_RGB(0, 154, 158);
    selectTextAttrs[NSFontAttributeName] = PingFangMediumFont(10);
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];

    [self addChildViewController:nav];

}



@end
