//
//  NSFileManager+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSFileManager+SCAdditions.h"

@implementation NSFileManager (SCAdditions)

+ (NSFileManager *)sc_threadSafeManager
{
	NSFileManager *instance = nil;
	
	@synchronized([self class]) {
		static NSMutableDictionary *sPerThreadInstances = nil;
		
		if (sPerThreadInstances == nil) {
			sPerThreadInstances = [[NSMutableDictionary alloc] init];
		}
		
		NSString *threadID = [NSString stringWithFormat:@"%p", [NSThread currentThread]];
		instance = [sPerThreadInstances objectForKey:threadID];
		
		if (instance == nil) {
			instance = [[[NSFileManager alloc] init] autorelease];
			[sPerThreadInstances setObject:instance forKey:threadID];
		}	 
	}
    
	return instance;	
}

- (BOOL)sc_isPathHidden:(NSString *)path
{
	LSItemInfoRecord itemInfo;
	NSURL *pathURL = [NSURL fileURLWithPath:path];
	
	return ((LSCopyItemInfoForURL((CFURLRef)pathURL, kLSRequestBasicFlagsOnly, &itemInfo) == noErr) &&
			(itemInfo.flags & kLSItemInfoIsInvisible));
}

- (BOOL)sc_createDirectoryPath:(NSString *)path attributes:(NSDictionary *)attributes
{
    BOOL result;
    BOOL isDir;
    
	if ([path isAbsolutePath]) {
		NSString *thePath = @"";
		NSEnumerator *enumerator = [[path pathComponents] objectEnumerator];
		NSString *component;
		
		while ((component = [enumerator nextObject]) != nil) {
			NSError *eatError = nil;
			thePath = [thePath stringByAppendingPathComponent:component];
			if (![self fileExistsAtPath:thePath] &&
				![self createDirectoryAtPath:thePath 
				 withIntermediateDirectories:YES
								  attributes:attributes
									   error:&eatError]) {
				[NSException raise:SCToolkitException format:@"createDirectory:attributes: failed at path: %@", path];
			}
		}
	}
	else {
		[NSException raise:SCToolkitException format:@"imb_createDirectoryPath:attributes: path not absolute:%@", path];
	}
	
    result = [self fileExistsAtPath:path isDirectory:&isDir];    
    return (result && isDir);
}

- (NSString *)sc_sharedTemporaryFolder:(NSString *)dirName
{
	NSString *directoryPath = NSTemporaryDirectory();
	if (dirName && ![dirName isEqualToString:@""]) {
		directoryPath = [directoryPath stringByAppendingPathComponent:dirName];
	}
	[self createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:NULL];
    return directoryPath;
}

@end
