//
//  NSString+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSString+SCAdditions.h"

@implementation NSString (SCAdditions)

+ (NSString *)sc_newUUIDString
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
	
#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
	return (NSString *)[(NSString *)uuidString autorelease];
#else
	return (NSString *)[NSMakeCollectable(uuidString) autorelease];
#endif
}

+ (NSString *)sc_stringFromTimeInterval:(NSTimeInterval)interval 
{
    int ts_ = (int)interval;
    int hours = ts_ / 3600;
    ts_ = ts_ % 3600;
    int minutes = ts_ / 60; 
    ts_ = ts_ % 60;
    int seconds = ts_ % 60;
    if (hours > 0)
        return [NSString stringWithFormat:@"J%2d:%02d:%02d", hours, minutes, seconds, nil];
    else
        return [NSString stringWithFormat:@"%d:%02d", minutes, seconds, nil];
}

- (NSString )sc_stringByAppendingPathComponent:(NSString *)component
{
    NSString *path = [self stringByAppendingPathComponent:component];
    return [path stringByExpandingTildeInPath];
}

- (BOOL)sc_isDirectory 
{
    BOOL isDirectory = NO;
    BOOL exists = [[NSFileManager sc_threadSafeManager] fileExistsAtPath:self isDirectory:&isDirectory];
    return (exists && isDirectory);
}

- (BOOL)sc_isFile 
{
    BOOL isDirectory = NO;
    BOOL exists = [[NSFileManager sc_threadSafeManager] fileExistsAtPath:self isDirectory:&isDirectory];
    return (exists && !isDirectory);
}

- (NSData *)sc_MD5 
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	return [data sc_MD5];
}

- (NSData *)sc_SHA1 
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	return [data sc_SHA1];
}

@end
