//
//  _cache_linked_list.h
//  KMCacheDemo
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class _cache_node;

@interface _cache_linked_list : NSObject
{
    @package
    
    CFMutableDictionaryRef _dic;
    
    __weak _cache_node *_head;
    __weak _cache_node *_tail;
    
    int _count;
    
    BOOL _releaseOnMainThread;
    BOOL _releaseAsynchronously;
}

- (void)appendNode:(_cache_node *)node;

- (void)removeNode:(_cache_node *)node;

- (nullable _cache_node *)removeHeadNode;

@end

NS_ASSUME_NONNULL_END

