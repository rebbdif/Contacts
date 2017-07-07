//
//  AppDelegate.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVAppDelegate.h"
#import "SLVTableController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface SLVAppDelegate ()

@end

@implementation SLVAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SLVTableController *tableController = [SLVTableController new];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:tableController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    return handled;
}

@end
