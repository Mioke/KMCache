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
#import <math.h>

#import <UIKit/UIKit.h>

@interface KMCache ()

//@property (nonatomic, strong) NSMutableDictionary *cache;

@property (nonatomic, strong) _cache_linked_list *cacheList;

@end

@implementation KMCache
{
    OSSpinLock _lock;
    NSUInteger _maxByte;
}

- (instancetype)init {
    if (self = [super init]) {
        self.type = KMCacheTypeDefualt;
        self.maxCount = INT_MAX;
        self.maxSize = NSIntegerMax;
        
        self.releaseOnMainThread = NO;
        self.releaseAsynchronously = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (instancetype)initWithType:(KMCacheType)type {
    if (self = [self init]) {
        self.type = type;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)setCacheObject:(id)object forKey:(NSString *)key {
    OSSpinLockLock(&_lock);
    @try {
        [self.cacheList appendNewNodeWithValue:object key:key];
        
        if (self.cacheList->_count > self.maxCount) {
            [self.cacheList removeHeadNode];
        }
        OSSpinLockUnlock(&_lock);
        return YES;
    }
    @catch (NSException *exception) {
        OSSpinLockUnlock(&_lock);
        return NO;
    }
}

- (nullable id)objectForKey:(id)key {
    
    OSSpinLockLock(&_lock);
    _cache_node *node = [self.cacheList nodeForKey:key];
    OSSpinLockUnlock(&_lock);
    if (!node) {
        return nil;
    }
    return node->_value;
}

- (void)cleanAllCache {
    
    OSSpinLockLock(&_lock);
    [self.cacheList removeAllNodes];
    OSSpinLockUnlock(&_lock);
}

- (void)cleanCacheByTime {
    
    if (self.type != KMCacheTypeReleaseByTime || self.cacheList->_count == 0) {
        return;
    }
    
    CFTimeInterval current = CACurrentMediaTime();
    OSSpinLockLock(&_lock);
    
    _cache_node *node = self.cacheList->_head;
    while (node->_time + self.releaseTime < current) {
        [self.cacheList removeNode:node];
        node = node->_next;
    }
    
    OSSpinLockUnlock(&_lock);
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

- (void)_didReceiveMemoryWarning {
    
    [self cleanAllCache];
}

#pragma mark - Getter and setter

- (void)setMaxSize:(NSUInteger)maxSize {
    _maxSize = maxSize;
    
    if (_maxSize < 1024) {
        _maxByte = _maxSize * sqrt(1024);
    }
}

//- (BOOL)releaseOnMainThread {
//    
//    OSSpinLockLock(&_lock);
//    BOOL releaseOnMainThread = self.cacheList->_releaseOnMainThread;
//    OSSpinLockUnlock(&_lock);
//    return releaseOnMainThread;
//}

- (void)setReleaseOnMainThread:(BOOL)releaseOnMainThread {
    
    _releaseOnMainThread = releaseOnMainThread;
    
    OSSpinLockLock(&_lock);
    self.cacheList->_releaseOnMainThread = releaseOnMainThread;
    OSSpinLockUnlock(&_lock);
}

//- (BOOL)releaseAsynchronously {
//    OSSpinLockLock(&_lock);
//    BOOL releaseAsynchronously = self.cacheList->_releaseAsynchronously;
//    OSSpinLockUnlock(&_lock);
//    return releaseAsynchronously;
//}

- (void)setReleaseAsynchronously:(BOOL)releaseAsynchronously {
    
    _releaseAsynchronously = releaseAsynchronously;
    
    OSSpinLockLock(&_lock);
    self.cacheList->_releaseAsynchronously = releaseAsynchronously;
    OSSpinLockUnlock(&_lock);
}

@end


