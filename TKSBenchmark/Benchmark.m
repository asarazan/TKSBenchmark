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
    volatile int64_t _readIterationsCompleted;
    volatile int64_t _writeIterationsCompleted;
    NSTimeInterval _startTime;
    NSTimeInterval _endTime;
    volatile int32_t _finished;
}

static inline void nothing(id obj)
{
    // Nothing
}

- (void)_finish;
{
    int requiredToFinish = !!_readThreads + !!_writeThreads;
    if (OSAtomicIncrement32(&_finished) == requiredToFinish) {
        _endTime = [[NSDate date] timeIntervalSince1970];
        NSLog(@"[%uR:%uW] %@ Finished %lld reads and %lld writes in %f seconds",
              _readThreads, _writeThreads,
              NSStringFromClass([_dictionary class]),
              _readIterationsCompleted, _writeIterationsCompleted,
              _endTime - _startTime);
        if (_onFinish) {
            _onFinish();
        }        
    }
}

- (void)run;
{
    CueTaskQueue *readQueue = [[CueTaskQueue alloc] initWithName:@"Benchmark-Read"];
    CueTaskQueue *writeQueue = [[CueTaskQueue alloc] initWithName:@"Benchmark-Write"];
    
    if (_readThreads) {
        [readQueue startWithThreadCount:_readThreads];
    }
    
    if (_writeThreads) {
        [writeQueue startWithThreadCount:_writeThreads];
    }
    
    _startTime = [[NSDate date] timeIntervalSince1970];
    for (int i = 0; i < _iterations; ++i) {
        if (_readThreads) {
            CueBlockTask *task = [CueBlockTask taskWithKey:nil priority:1.0 executionBlock:^(CueTask *task) {
                id key = @(arc4random() % 100);
                id obj = [_dictionary objectForKey:key];
                nothing(obj);                
                if (OSAtomicIncrement64(&_readIterationsCompleted) == _iterations) {
                    [self _finish];
                }
            }];
            [readQueue addTask:task];
        }        
        if (_writeThreads) {
            CueBlockTask *task = [CueBlockTask taskWithKey:nil priority:1.0 executionBlock:^(CueTask *task) {
                id key = @(arc4random() % 100);
                [_dictionary setObject:@"val" forKey:key];
                if (OSAtomicIncrement64(&_writeIterationsCompleted) == _iterations) {
                    [self _finish];
                }
            }];
            [writeQueue addTask:task];
        }       
    }
}

@end
