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

- (BOOL)sc_createDirectoryRecursively:(NSString *)path error:(NSError **)error
{
//	// Check Folder  exists
//	BOOL bRet = NO;
//	NSString *realPath = [path stringByExpandingTildeInPath];
//	//TODO: What if file is existed and is not a directory??
//    // create foler
//    NSFileManager *fm = [[NSFileManager alloc] init];
//    // even when the parent folder is not exist, this function will creat all folder for u!
//    [fm createDirectoryAtPath:realPath withIntermediateDirectories:YES attributes:nil error:nil];
//    [fm release];
    return YES;
}
@end
