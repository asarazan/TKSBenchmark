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

static NSUInteger iterations = 5000;
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

- (void)_testLock:(void (^)())onFinish;
{
    Benchmark *b = [[Benchmark alloc] init];
    b.dictionary = [@{} cueConcurrent];
    b.readThreads = readThreads;
    b.writeThreads = writeThreads;
    b.iterations = iterations;
    b.onFinish = onFinish;
    [b run];    
}

- (void)_testDispatch:(void (^)())onFinish;
{
    Benchmark *b = [[Benchmark alloc] init];
    b.dictionary = [[DispatchDictionary alloc] init];
    b.readThreads = readThreads;
    b.writeThreads = writeThreads;
    b.iterations = iterations;
    b.onFinish = onFinish;
    [b run];
}

- (void)_test;
{
    [self _testLock:^{
        [self cuePerformSelectorOnMainThread:@selector(_testDispatch:) withObject:nil afterDelay:1.0f];
    }];
}

@end
