//
//  KMCache.m
//  swiftArchitecture
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import "KMCache.h"
#import "_cache_linked_list.h"
#import <libkern/OSAtomic.h>

@interface KMCache ()

//@property (nonatomic, strong) NSMutableDictionary *cache;

@property (nonatomic, strong) _cache_linked_list *cacheList;

@end

@implementation KMCache
{
    OSSpinLock _lock;
}

- (instancetype)init {
    if (self = [super init]) {
        self.type = KMCacheTypeDefualt;
        self.maxCount = NSIntegerMax;
        self.maxSize = NSIntegerMax;
    }
    return self;
}

- (instancetype)initWithType:(KMCacheType)type {
    if (self = [self init]) {
        self.type = type;
    }
    return self;
}

- (BOOL)setCacheObject:(id)object forKey:(NSString *)key {
    
    @try {
        [self.cacheList appendNewNodeWithValue:object key:key];
        return YES;
    }
    @catch (NSException *exception) {
        return NO;
    }
}

- (void)cleanCacheByTime {
    
    
}

- (void)cleanCacheBySize {
    
}

- (_cache_linked_list *)cacheList {
    
    if (!_cacheList) {
        _cacheList = [[_cache_linked_list alloc] init];
    }
    return _cacheList;
}

- (NSUInteger)size {
    
    OSSpinLockLock(&_lock);
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.cacheList forKey:@"sizeKey"];
    [archiver finishEncoding];
    OSSpinLockUnlock(&_lock);
    
    NSLog(@"%ld", data.length);
    
    return data.length;
}

@end


