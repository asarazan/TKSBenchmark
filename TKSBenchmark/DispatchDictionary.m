//
//  DispatchDictionary.m
//  TKSBenchmark
//
//  Created by Aaron Sarazan on 5/14/13.
//  Copyright (c) 2013 Cue. All rights reserved.
//

#import "DispatchDictionary.h"

@implementation DispatchDictionary {
    NSMutableDictionary *_dictionary;
    dispatch_queue_t _queue;
}

- (id)init;
{
    self = [super init];
    if (self) {
        _dictionary = [@{} mutableCopy];
        _queue = dispatch_queue_create("DispatchDictionary", NULL);
    }
    return self;
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;
{
    dispatch_barrier_sync(_queue, ^{        
        [_dictionary setObject:anObject forKey:aKey];
    });
}

- (id)objectForKey:(id)aKey;
{
    __block id retval = nil;
    dispatch_sync(_queue, ^{
        retval = [_dictionary objectForKey:aKey];
    });
    return retval;
}

- (NSString *)description;
{
    return _dictionary.description;
}

@end
