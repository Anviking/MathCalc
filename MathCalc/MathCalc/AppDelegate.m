//
//  AppDelegate.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationControllerDelegate.h"
#import "MasterViewController.h"
#import "BackgroundView.h"
#import "MathCore.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.tintColor = [UIColor colorWithHue:0.4 saturation:0.6 brightness:0.8 alpha:1.0];
    
    self.window.tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBarTintColor:self.tintColor];
    [[UITextField appearance] setTintColor:self.tintColor];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UINavigationController *navigationController = self.window.rootViewController;
    MasterViewController *viewController = navigationController.viewControllers.firstObject;
    for (NSArray *array in viewController.array) {
        for (Shape *shape in array) {
            [shape save];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Convenience

+ (AppDelegate *)delegate
{
    return [UIApplication sharedApplication].delegate;
}

+ (UIColor *)tintColor
{
    return [AppDelegate delegate].tintColor;
}



@end
