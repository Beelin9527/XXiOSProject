//
//  AppDelegate.m
//  XXiOSProject
//
//  Created by Beelin on 17/6/9.
//  Copyright © 2017年 xx. All rights reserved.
//

#import "AppDelegate.h"

#import "XXTabBarController.h"

#import "JLRoutes.h"

#import "AppDelegate+XXExtension.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    XXTabBarController *tabBarController = [[XXTabBarController alloc] init];
    window.rootViewController = tabBarController;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    self.window = window;
    
    [self xx_navigationGlobalConfig];

    [JLRoutes.globalRoutes addRoute:@"/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *c = parameters[@"controller"];
        [self.window.rootViewController presentViewController:[[NSClassFromString(c) alloc] init] animated:YES completion:nil];
        return YES;
    }];
    
    return YES;
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"从哪个app跳转而来 Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    
    return [JLRoutes routeURL:url];
    return YES;
}

@end
