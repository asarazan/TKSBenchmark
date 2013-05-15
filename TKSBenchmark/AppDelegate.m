//
//  AppDelegate.m
//  TKSBenchmark
//
//  Created by Aaron Sarazan on 5/14/13.
//  Copyright (c) 2013 Cue. All rights reserved.
//

#import "AppDelegate.h"
#import "TheKitchenSync.h"
#import "Benchmark.h"
#import "DispatchDictionary.h"

static NSUInteger iterations = 800000;
static NSUInteger readThreads = 4;
static NSUInteger writeThreads = 0;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self _test];
    
    return YES;
}

- (void)_testLock;
{
    Benchmark *b = [[Benchmark alloc] init];
    b.dictionary = [@{} cueConcurrent];
    b.readThreads = readThreads;
    b.writeThreads = writeThreads;
    b.iterations = iterations;
    [b run];    
}

- (void)_testDispatch;
{
    Benchmark *b = [[Benchmark alloc] init];
    b.dictionary = [[DispatchDictionary alloc] init];
    b.readThreads = readThreads;
    b.writeThreads = writeThreads;
    b.iterations = iterations;
    [b run];
}

- (void)_test;
{
    bool testLock = true;
    while (1) {
        if (testLock) {
            [self _testLock];
        } else {
            [self _testDispatch];
        }
        testLock = !testLock;
    }
}

@end
