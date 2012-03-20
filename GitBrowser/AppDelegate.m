//
//  AppDelegate.m
//  GitBrowser
//
//  Created by Peter Friese on 19.03.12.
//  Copyright (c) 2012 peterfriese.de. All rights reserved.
//

#import "AppDelegate.h"
#import "UserDetailsController.h"
#import "BrowseReposViewController.h"

@implementation AppDelegate

@synthesize example1;
@synthesize tabbarController;

@synthesize window = _window;
@synthesize manager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [RKObjectManager objectManagerWithBaseURL:@"https://api.github.com"];
    
    // Example 1: fetch Octocat image
    example1 = [[Example1ViewController alloc] init];
    example1.tabBarItem.title = @"Example 1";
    
    // User Details: fetch and map XML data
    UserDetailsController *userDetails = [[UserDetailsController alloc] init];
    userDetails.protocol = @"xml";
    [userDetails setUserName:@"octocat"];
    
    // User Details: fetch and map XML data
    UserDetailsController *userDetailsWitjJSON = [[UserDetailsController alloc] init];
    userDetailsWitjJSON.protocol = @"json";
    [userDetailsWitjJSON setUserName:@"peterfriese"];
    
    // Browse repos
    BrowseReposViewController *browseViewController = [[BrowseReposViewController alloc] init];
    UINavigationController *browseReposNavigationController = [[UINavigationController alloc] initWithRootViewController:browseViewController];
    browseReposNavigationController.tabBarItem.title = @"Browse";
    
    // Set up tab bar
    tabbarController = [[UITabBarController alloc] init];
    [tabbarController setViewControllers:[NSArray arrayWithObjects:
                                          example1, 
                                          userDetails, 
                                          userDetailsWitjJSON, 
                                          browseReposNavigationController, 
                                          nil]];    
    [self.window addSubview:tabbarController.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
