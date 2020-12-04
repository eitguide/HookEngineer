//
//  ViewController.m
//  Engineer
//
//  Created by nghianv on 12/4/20.
//

#import "ViewController.h"
#include <Foundation/Foundation.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <CydiaSubstrate/CydiaSubstrate.h>

@interface ViewController ()

@end

@implementation ViewController

NSString *(*oldDescription)(id class, SEL _cmd);
NSString *newDescription(id class, SEL _cmd) {
    NSString *description = (*oldDescription)(class, _cmd);
    description = [description stringByAppendingString:@"Test!"];
    return description;
}

void (*originSetFrame)(id class, SEL _cmd, CGRect frame);
void replaceSetFrame(id class, SEL _cmd, CGRect frame) {
    NSLog(@"Set frame");
    originSetFrame(class, _cmd, frame);
}

id (*originValueForKey)(id class, SEL _cmd, NSString* key);
id replaceValueForKey(id class, SEL _cmd, NSString* key) {
    NSLog(@"valueForKey");
    return originValueForKey(class, _cmd, key);
}

void (*originSetBackgroundColor)(id class, SEL _cmd, UIColor* color);
void replaceSetBackgroundColor(id class, SEL _cmd, UIColor* color) {
    NSLog(@"setBackgroundColor");
    originSetBackgroundColor(class, _cmd, [UIColor purpleColor]);
};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MSHookMessageEx([UIView class],
                    @selector(setFrame:),
                    &replaceSetFrame,
                    &originSetFrame);
    
    MSHookMessageEx([UIApplication class],
                    @selector(valueForKey:),
                    &replaceValueForKey,
                    &originValueForKey);
    
    MSHookMessageEx([UIView class],
                    @selector(setBackgroundColor:),
                    &replaceSetBackgroundColor,
                    &originSetBackgroundColor);
    
    UIView *childView = [UIView new];
    [childView setFrame:CGRectMake(0, 0, 100, 100)];
    [[[UIApplication sharedApplication] valueForKey:@"statusBar"] setBackgroundColor:[UIColor greenColor]];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
}



//static mach_port_t getFrontMostAppPort() {
//
//    if([frontmostApp length] == 0 || locked)
//        return GSGetPurpleSystemEventPort();
//    else
//        return GSCopyPurpleNamedPort(appId);
//}

@end
