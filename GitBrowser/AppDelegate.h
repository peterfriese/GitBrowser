//
//  AppDelegate.h
//  GitBrowser
//
//  Created by Peter Friese on 19.03.12.
//  Copyright (c) 2012 peterfriese.de. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Example1ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Example1ViewController *example1;
@property (strong, nonatomic) UITabBarController *tabbarController;

@end
