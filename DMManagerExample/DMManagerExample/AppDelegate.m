//
//  AppDelegate.m
//  DMManagerExample
//
//  Created by Шурик on 06.12.14.
//  Copyright (c) 2014 Alexandr Zhovty. All rights reserved.
//

#import "AppDelegate.h"

#import <DMManager/DMManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%s %@", __FUNCTION__, [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"]);
    
    NSManagedObjectContext *context = [[DMManager sharedManager] defaultContext];
    context = nil;
    
    return YES;
}



@end
