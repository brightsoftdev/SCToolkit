//
//  NSWorkspace+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSWorkspace+SCAdditions.h"

@implementation NSWorkspace (SCAdditions)

+ (NSWorkspace *)sc_threadSafeWorkspace
{
    NSWorkspace *instance = nil;
    
	static NSString *sMutex = @"threadSafeWorkspaceMutex";
    
	@synchronized(sMutex) {
		static NSMutableDictionary *sPerThreadInstances = nil;
        
		if (sPerThreadInstances == nil) sPerThreadInstances = [[NSMutableDictionary alloc] init];
		
		NSString *threadID = [NSString stringWithFormat:@"%p",[NSThread currentThread]];
        
		instance = [sPerThreadInstances objectForKey:threadID];
        
		if (instance == nil) {
			instance = [[[NSWorkspace alloc] init] autorelease];
			[sPerThreadInstances setObject:instance forKey:threadID];
		}	 
	}
    
	return instance;	
}

- (NSImage *)sc_iconForAppWithBundleIdentifier:(NSString *)bundleID
{
    NSString *path = [self absolutePathForAppBundleWithIdentifier:bundleID];
    
    // Since there is no customized icon been added and set, just return the default icon
	if (nil == path) return [NSImage imageNamed:@"NSDefaultApplicationIcon"];

	return [self iconForFile:path];
}

- (NSImage *)sc_iconForFile:(NSString *)path size:(NSSize)size
{
    if (path) {
		NSImage *icon = [self iconForFile:path];
		[icon setScalesWhenResized:YES];
		[icon setSize:size];
		return icon;
	}
	
	return nil;
}

@end
