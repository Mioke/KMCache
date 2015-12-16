//
//  _cache_linked_list.m
//  KMCacheDemo
//
//  Created by Klein Mioke on 15/12/15.
//  Copyright © 2015年 KleinMioke. All rights reserved.
//

#import "_cache_linked_list.h"
#import <CoreFoundation/CoreFoundation.h>

#import <libkern/OSAtomic.h>

@interface _cache_node : NSObject
{
    @package
    NSTimeInterval _time;
    id _key;
    id _value;
    __unsafe_unretained _cache_node *_prev;
    __unsafe_unretained _cache_node *_next;
}
@end

@implementation _cache_node
@end

@interface _cache_linked_list ()

@end

@implementation _cache_linked_list

- (instancetype)init {
    if (self = [super init]) {
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

- (void)dealloc {
    CFRelease(_dic);
}

- (void)appendNode:(nonnull _cache_node *)node {
    
    if (_count == 0) {
        _head = node;
        _tail = node;
    } else {
        node->_prev = _tail;
        _tail->_next = node;
        _tail = node;
    }
    CFDictionarySetValue(_dic, (__bridge const void *)(node->_key), (__bridge const void *)(node));
    
    _count ++;
}

- (_cache_node *)removeNode:(_cache_node *)node {
    
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(node->_key));
    
    if (node->_prev) {
        node->_prev->_next = node->_next;
    }
    if (node->_next) {
        node->_next->_prev = node->_prev;
    }
    if (_head == node) {
        _head = node->_next;
    }
    if (_tail == node) {
        _tail = node->_prev;
    }
    _count --;
    return node;
}

- (nullable _cache_node *)removeHeadNode {
    
    return _head;
}

@end
