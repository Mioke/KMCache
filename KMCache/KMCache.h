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

- (BOOL)setCacheObject:(id)object forKey:(NSString *)key;

- (unsigned long long)size;

@end

NS_ASSUME_NONNULL_END
