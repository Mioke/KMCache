//
//  KMCache.h
//  swiftArchitecture
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  KMCache type
 */
typedef NS_OPTIONS(int, KMCacheType) {
    /**
     *  only count
     */
    KMCacheTypeDefualt       = 0,
    /**
     *  depend on time, ignore size
     */
    KMCacheTypeReleaseByTime = 1 << 1,
    /**
     *  depend on size, ignore time
     */
    KMCacheTypeReleaseBySize = 1 << 2
};

@interface KMCache : NSObject

@property (nonatomic, assign) KMCacheType type;

- (instancetype)initWithType:(KMCacheType)type;

/**
 *  The max number of cached objects' count. By default, the max count is unlimited (INT_MAX).
 */
@property (nonatomic, assign) int maxCount;

/**
 *  The max size of cached objects, unit is 'Mb'. By default, the max size is unlimited(NSIntegerMax).
 */
@property (nonatomic, assign) NSUInteger maxSize;
/**
 *  How long should the cache stay, available with type .ReleaseByTime
 */
@property (nonatomic, assign) NSTimeInterval releaseTime;
/**
 *  Clean caches on main thread, default is NO;
 */
@property (nonatomic, assign) BOOL releaseOnMainThread;
/**
 *  Clean caches asynchronously, default is YES;
 */
@property (nonatomic, assign) BOOL releaseAsynchronously;

/**
 *  Cache object.
 *
 *  @param object object need to cache
 *  @param key    key of cached object
 *
 *  @return succeed or not
 */
- (BOOL)setCacheObject:(id)object forKey:(NSString *)key;
/**
 *  The size of cached data
 */
- (NSUInteger)size;

@end

NS_ASSUME_NONNULL_END
