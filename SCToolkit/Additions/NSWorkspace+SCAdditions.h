//
//  NSWorkspace+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSWorkspace (SCAdditions)

+ (NSWorkspace *)sc_threadSafeWorkspace;
- (NSImage *)sc_iconForAppWithBundleIdentifier:(NSString *)bundleID;
- (NSImage *)sc_iconForFile:(NSString *)path size:(NSSize)size;

@end
