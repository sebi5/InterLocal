//
//  AppDelegate.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"
#import "InitView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"Registering for push notifications...");
    //[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
   //  (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];


    NSString* loggedIn_check = [[NSUserDefaults standardUserDefaults] stringForKey:@"loggedIn"];
    if (![loggedIn_check isEqualToString:@"YES"]) {

        InitView *vc = [[InitView alloc] init];
        UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = vc2;
        NSLog(@"Not logged IN yet");
        
        
    }
    else{
        
        MainView *vc = [[MainView alloc] init];
        //UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = vc;
        
    }
  
   // [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"content---");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
