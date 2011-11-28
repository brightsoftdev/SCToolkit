//
//  NSString+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSString+SCAdditions.h"

@implementation NSString (SCAdditions)

+ (NSString *)newUUIDString
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

@end
