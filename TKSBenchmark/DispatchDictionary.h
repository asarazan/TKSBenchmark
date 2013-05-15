//
//  DispatchDictionary.h
//  TKSBenchmark
//
//  Created by Aaron Sarazan on 5/14/13.
//  Copyright (c) 2013 Cue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispatchDictionary : NSObject

- (id)objectForKey:(id)aKey;

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
