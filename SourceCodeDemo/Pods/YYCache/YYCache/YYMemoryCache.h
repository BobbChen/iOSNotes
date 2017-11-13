//
//  YYMemoryCache.h
//  YYCache <https://github.com/ibireme/YYCache>
//
//  Created by ibireme on 15/2/7.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 YYMemoryCache is a fast in-memory cache that stores key-value pairs.
 In contrast to NSDictionary, keys are retained and not copied.
 The API and performance is similar to `NSCache`, all methods are thread-safe.
 
 YYMemoryCache objects differ from NSCache in a few ways:
 
 * It uses LRU (least-recently-used) to remove objects; NSCache's eviction method
   is non-deterministic.
 * It can be controlled by cost, count and age; NSCache's limits are imprecise.
 * It can be configured to automatically evict objects when receive memory 
   warning or app enter background.
 
 The time of `Access Methods` in YYMemoryCache is typically in constant time (O(1)).
 */
@interface YYMemoryCache : NSObject

#pragma mark - Attribute
///=============================================================================
/// @name Attribute
///=============================================================================

/** The name of the cache. Default is nil. */
@property (nullable, copy) NSString *name;

/** The number of objects in the cache (read-only) */
@property (readonly) NSUInteger totalCount;

/** The total cost of objects in the cache (read-only). */
@property (readonly) NSUInteger totalCost;


#pragma mark - Limit，超过限制之后会自动删除部分缓存内容

// 缓存对象数量限制
@property NSUInteger countLimit;

// 缓存开销数量限制
@property NSUInteger costLimit;

// 缓存时间限制
@property NSTimeInterval ageLimit;

// 自动清理缓存的时间
@property NSTimeInterval autoTrimInterval;

// 是否在收到警告立马删除所有缓存
@property BOOL shouldRemoveAllObjectsOnMemoryWarning;

// 是否在进入后台删除所有缓存
@property BOOL shouldRemoveAllObjectsWhenEnteringBackground;

/**
 A block to be executed when the app receives a memory warning.
 The default value is nil.
 */
@property (nullable, copy) void(^didReceiveMemoryWarningBlock)(YYMemoryCache *cache);

/**
 A block to be executed when the app enter background.
 The default value is nil.
 */
@property (nullable, copy) void(^didEnterBackgroundBlock)(YYMemoryCache *cache);

/**
 If `YES`, the key-value pair will be released on main thread, otherwise on
 background thread. Default is NO.
 
 @discussion You may set this value to `YES` if the key-value object contains
 the instance which should be released in main thread (such as UIView/CALayer).
 */
@property BOOL releaseOnMainThread;

/**
 If `YES`, the key-value pair will be released asynchronously to avoid blocking 
 the access methods, otherwise it will be released in the access method  
 (such as removeObjectForKey:). Default is YES.
 */
@property BOOL releaseAsynchronously;


#pragma mark - Access Methods
///=============================================================================
/// @name Access Methods
///=============================================================================

/**
 Returns a Boolean value that indicates whether a given key is in cache.
 
 @param key An object identifying the value. If nil, just return `NO`.
 @return Whether the key is in cache.
 */
- (BOOL)containsObjectForKey:(id)key;

/**
 Returns the value associated with a given key.
 
 @param key An object identifying the value. If nil, just return nil.
 @return The value associated with key, or nil if no value is associated with key.
 */
- (nullable id)objectForKey:(id)key;

/**
 Sets the value of the specified key in the cache (0 cost).
 
 @param object The object to be stored in the cache. If nil, it calls `removeObjectForKey:`.
 @param key    The key with which to associate the value. If nil, this method has no effect.
 @discussion Unlike an NSMutableDictionary object, a cache does not copy the key 
 objects that are put into it.
 */
- (void)setObject:(nullable id)object forKey:(id)key;

/**
 Sets the value of the specified key in the cache, and associates the key-value 
 pair with the specified cost.
 
 @param object The object to store in the cache. If nil, it calls `removeObjectForKey`.
 @param key    The key with which to associate the value. If nil, this method has no effect.
 @param cost   The cost with which to associate the key-value pair.
 @discussion Unlike an NSMutableDictionary object, a cache does not copy the key
 objects that are put into it.
 */
- (void)setObject:(nullable id)object forKey:(id)key withCost:(NSUInteger)cost;

/**
 Removes the value of the specified key in the cache.
 
 @param key The key identifying the value to be removed. If nil, this method has no effect.
 */
- (void)removeObjectForKey:(id)key;

/**
 Empties the cache immediately.
 */
- (void)removeAllObjects;


#pragma mark - 三种LRU缓存控制方式：缓存数量、缓存容量、缓存时间

// 数量
- (void)trimToCount:(NSUInteger)count;

// 容量
- (void)trimToCost:(NSUInteger)cost;

// 缓存时间
- (void)trimToAge:(NSTimeInterval)age;

@end

NS_ASSUME_NONNULL_END
