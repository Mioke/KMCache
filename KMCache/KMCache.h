//
//  KMCache.h
//  swiftArchitecture
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(int, KMCacheType) {
    
    KMCacheTypeDefualt       = 1 << 0,
    
    KMCacheTypeReleaseByTime = 1 << 1,
    KMCacheTypeReleaseBySize = 1 << 2
};

@interface KMCache : NSObject

@property (nonatomic, assign) KMCacheType type;

- (instancetype)initWithType:(KMCacheType)type;

/**
 *  The max number of cached objects' count. By default, the max count is unlimited (NSIntegerMax).
 */
@property (nonatomic, assign) NSInteger maxCount;

/**
 *  The max size of cached objects, unit is 'Mb'. By default, the max size is unlimited(NSIntegerMax).
 */
@property (nonatomic, assign) NSUInteger maxSize;

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
