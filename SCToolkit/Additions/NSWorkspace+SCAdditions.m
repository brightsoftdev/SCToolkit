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

- (void)sc_openSystemPreference:(NSString *)preferencesFileName 
{
	NSFileManager *fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:[@"/System/Library/PreferencePanes/" stringByAppendingString:preferencesFileName]]) {
		[[NSWorkspace sharedWorkspace] openFile:[@"/System/Library/PreferencePanes/" stringByAppendingString:preferencesFileName]];
	} 
	else if ([fm fileExistsAtPath:[@"~/Library/PreferencePanes/" stringByAppendingString:preferencesFileName]]) {
		[[NSWorkspace sharedWorkspace] openFile:[@"~/Library/PreferencePanes/" stringByAppendingString:preferencesFileName]];
	}
}

- (void)sc_bringApplicationToFront:(NSDictionary *)appInfo 
{
	if (appInfo == nil) return;
	NSString *appath = [appInfo valueForKey:@"NSApplicationPath"];
	if (appath == nil) return;
	[self launchApplication:appath];
}

- (void)sc_bringCurrentApplicationToFront 
{
	[self launchApplication:[[NSBundle mainBundle] bundlePath]];
}

- (void)sc_bringApplicationToFrontFromPath:(NSString *)appPath 
{
	if (!appPath) return;
	[self launchApplication:appPath];
}

- (void)sc_uninstallStartupLaunchdItem:(NSString *)plistName 
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *file = [[@"~/Library/LaunchAgents" stringByExpandingTildeInPath] stringByAppendingString:[@"/" stringByAppendingString:plistName]];
	[fm removeItemAtPath:file error:NULL];
}

- (void)sc_installStartupLaunchdItem:(NSString *)plistName 
{
	if (!plistName) return;
	NSBundle *bundle = [NSBundle mainBundle];
	NSFileManager *fm = [NSFileManager sc_threadSafeManager];
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	[attrs setObject:[NSNumber numberWithUnsignedLong:448] forKey:NSFilePosixPermissions];
	NSString *path = [bundle pathForResource:[plistName stringByDeletingPathExtension] ofType:@"plist"];
	NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	NSString *executablepath = [bundle executablePath];
	[plist setObject:executablepath forKey:@"Program"];
	NSString *dest = [[@"~/Library/LaunchAgents" stringByExpandingTildeInPath] stringByAppendingString:[@"/" stringByAppendingString:plistName]];	
	[fm createDirectoryAtPath:[@"~/Library/LaunchAgents/" stringByExpandingTildeInPath] withIntermediateDirectories:TRUE attributes:attrs error:nil];
	[plist writeToFile:dest atomically:YES];
	[plist release];
    [attrs release];
}

@end
