//
//  AppDelegate.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SearchUserViewModel.h"
#import "SearchUserViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SearchUserViewModel* searchUserViewModel = [[SearchUserViewModel alloc] init];
    UIViewController* viewController = [[SearchUserViewController alloc] initWithViewModel:searchUserViewModel];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
