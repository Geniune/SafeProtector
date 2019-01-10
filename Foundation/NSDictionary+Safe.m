//
//  NSDictionary+Safe.m
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+SafeSwizzle.h"
#import "NSObject+SafeProtector.h"

@implementation NSDictionary (Safe)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:objc_getClass("__NSPlaceholderDictionary") selector:@selector(initWithObjects:forKeys:) withSwizzledSelector:@selector(safe_initWithObjects:forKeys:)];
        [self exchangeInstance:objc_getClass("__NSPlaceholderDictionary") selector:@selector(initWithObjects:forKeys:count:) withSwizzledSelector:@selector(safe_initWithObjects:forKeys:count:)];
        [self exchangeInstance:[self class] selector:@selector(dictionaryWithObjects:forKeys:count:) withSwizzledSelector:@selector(safe_dictionaryWithObjects:forKeys:count:)];
    });
}

- (instancetype)safe_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys{
    
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects forKeys:keys];
    }
    @catch (NSException *exception) {
        
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSDictionary);
        
        //处理错误的数据，重新初始化一个字典
        NSUInteger count=MIN(objects.count, keys.count);
        NSMutableArray *newObjects=[NSMutableArray array];
        NSMutableArray *newKeys=[NSMutableArray array];
        for (int i = 0; i < count; i++) {
            if (objects[i] && keys[i]) {
                [newObjects addObject:objects[i]];
                [newKeys addObject:keys[i]];
            }
        }
        instance = [self safe_initWithObjects:newObjects forKeys:newKeys];
    }
    @finally {
        return instance;
    }
}

- (instancetype)safe_initWithObjects:(id _Nonnull const [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)count{
    
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects forKeys:keys count:count];
    }
    @catch (NSException *exception) {
        
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSDictionary);
        
        //处理错误的数据，重新初始化一个字典
        NSUInteger index = 0;
        id   newObjects[count];
        id   newkeys[count];
        
        for (int i = 0; i < count; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safe_initWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

+ (instancetype)safe_dictionaryWithObjects:(id _Nonnull const [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)count {
    
    id instance = nil;
    @try {
        instance = [self safe_dictionaryWithObjects:objects forKeys:keys count:count];
    }
    @catch (NSException *exception) {
        
        LSSafeProtectionCrashLog(exception,LSSafeProtectorCrashTypeNSDictionary);
        
        //处理错误的数据，重新初始化一个字典
        NSUInteger index = 0;
        id   newObjects[count];
        id   newkeys[count];
        
        for (int i = 0; i < count; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safe_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    
    NSMutableString *stringM = [NSMutableString string];
    [stringM appendString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [stringM appendFormat:@"\t%@ = %@;\n",key,obj];
    }];
    
    [stringM appendString:@"}\n"];
    
    return stringM;
}


@end
