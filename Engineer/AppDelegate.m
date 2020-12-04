//
//  AppDelegate.m
//  Engineer
//
//  Created by nghianv on 12/4/20.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *viewController = [[ViewController alloc] init];
    viewController.view.backgroundColor = [UIColor redColor];
    _window.rootViewController = viewController;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
