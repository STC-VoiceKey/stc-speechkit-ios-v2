//
//  AppDelegate.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 17.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UITabBar.appearance.tintColor    = [UIColor colorWithRed:092.0/255.0 green:107.0/255.0 blue:192.0/255.0  alpha:1];
    UITabBar.appearance.barTintColor = [UIColor colorWithRed:030.0/255.0 green:045.0/255.0 blue:125.0/255.0  alpha:1];
    
    return YES;
}

@end
