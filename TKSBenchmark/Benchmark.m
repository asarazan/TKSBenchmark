//
//  Benchmark.m
//  TKSBenchmark
//
//  Created by Aaron Sarazan on 5/14/13.
//  Copyright (c) 2013 Cue. All rights reserved.
//

#import "Benchmark.h"
#import "TheKitchenSync.h"
#import <libkern/OSAtomic.h>

@implementation Benchmark {
    NSTimeInterval _startTime;
    NSTimeInterval _endTime;
}

static inline void nothing(id obj)
{
    int objInt = (int)obj;
    objInt++;
}

- (void)_finish;
{
    _endTime = [[NSDate date] timeIntervalSince1970];
    printf("[%uR:%uW] %s Finished %u reads and %u writes in %f seconds\n",
           _readThreads, _writeThreads,
           NSStringFromClass([_dictionary class]).UTF8String,
           _readThreads ? _iterations : 0, _writeThreads ? _iterations : 0,
           _endTime - _startTime);
}

- (void)run;
{
    CueTaskQueue *readQueue = [[CueTaskQueue alloc] initWithName:@"Benchmark-Read"];
    CueTaskQueue *writeQueue = [[CueTaskQueue alloc] initWithName:@"Benchmark-Write"];
        
    for (int i = 0; i < 100; ++i) {
        [_dictionary setObject:@([[NSDate date] timeIntervalSince1970]) forKey:@(i)];
    }
    
    volatile __block int64_t readsCompleted = 0;
    volatile __block int64_t writesCompleted = 0;
    
    _startTime = [[NSDate date] timeIntervalSince1970];
    if (_readThreads) {
        CueBlockTask *task = [CueBlockTask taskWithKey:@0 priority:1.0 executionBlock:^(CueTask *task) {
            for (int i = 0; i < _iterations; ++i) {
                id key = @(arc4random() % 100);
                id obj = [_dictionary objectForKey:key];
                nothing(obj);
                OSAtomicIncrement64(&readsCompleted);
            }
        }];
        [readQueue addTask:task];
    }
    if (_writeThreads) {
        CueBlockTask *task = [CueBlockTask taskWithKey:@0 priority:1.0 executionBlock:^(CueTask *task) {
            for (int i = 0; i < _iterations; ++i) {
                id key = @(arc4random() % 100);
                [_dictionary setObject:@([[NSDate date] timeIntervalSince1970]) forKey:key];
                OSAtomicIncrement64(&writesCompleted);
            }
        }];
        [writeQueue addTask:task];
    }
    
    if (_readThreads) {
        [readQueue startWithThreadCount:_readThreads];
        [readQueue finish];
    }
    
    if (_writeThreads) {
        [writeQueue startWithThreadCount:_writeThreads];
        [writeQueue finish];        
    }
    
    NSAssert(!_readThreads || readsCompleted == _iterations, @"Didn't complete all read iterations");
    NSAssert(!_writeThreads || writesCompleted == _iterations, @"Didn't complete all write iterations");
    
    [self _finish];
}

@end
