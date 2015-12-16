//
//  KMCache.m
//  swiftArchitecture
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import "KMCache.h"
#import "_cache_linked_list.h"

@interface KMCache ()

@property (nonatomic, strong) NSMutableDictionary *cache;

@property (nonatomic, strong) _cache_linked_list *cacheList;

@end

@implementation KMCache

- (instancetype)init {
    if (self = [super init]) {
        self.type = KMCacheTypeDefualt;
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
    
    [self.cache setObject:object forKey:key];
    
    return YES;
}

- (void)cleanCacheByTime {
    

}

- (void)cleanCacheBySize {
    
}

- (NSMutableDictionary *)cache {
    if (_cache == nil) {
        _cache = [[NSMutableDictionary alloc] init];
    }
    return _cache;
}

- (unsigned long long)size {
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.cache forKey:@"sizeKey"];
    [archiver finishEncoding];
    
    NSLog(@"%ld", data.length);
    
    return self.cache.fileSize;
}

@end


