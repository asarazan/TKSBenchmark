//
//  Benchmark.h
//  TKSBenchmark
//
//  Created by Aaron Sarazan on 5/14/13.
//  Copyright (c) 2013 Cue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Benchmark : NSObject

@property id dictionary;

@property NSUInteger readThreads;

@property NSUInteger writeThreads;

@property NSUInteger iterations;

@property (copy) void (^onFinish)(void);

- (void)run;

@end
