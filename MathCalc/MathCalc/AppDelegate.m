//
//  AppDelegate.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationControllerDelegate.h"
#import "BackgroundView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window.tintColor = [UIColor whiteColor];
    self.window.backgroundColor = [UIColor colorWithRed:46.0/255.0 green:120.0/255.0 blue:208.0/255 alpha:1];
    
    [self updateInterface];
    
    return YES;
}

- (void)updateInterface
{
    BackgroundView *view = [[BackgroundView alloc] initWithFrame:self.window.frame];
    [self.window insertSubview:view atIndex:0];
    
    [[UINavigationBar appearance] setAlpha:0];
    [[UITableView appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UILabel appearance] setTextColor:[UIColor whiteColor]];
    [[UITableView appearance] setSeparatorColor:[UIColor clearColor]];
    
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    [navigationController.navigationBar setBackgroundImage:[UIImage new]
                                             forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = YES;
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

@end
