//
//  NSBundle+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/30/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSBundle+SCAdditions.h"

static NSImage *_SCCacheImageFromBundle(NSBundle *bundle, NSString *key) 
{
	NSImage *image = nil;
	NSString *name = [bundle objectForInfoDictionaryKey:key];
    
	image = [NSImage imageNamed:name];
	if (image != nil) return image;
    
	image = [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:name]];
	[image setName:name];
    
	return image;
}

@implementation NSBundle (SCAdditions)

- (NSImage *)sc_icon 
{
	return _SCCacheImageFromBundle(self, @"CFBundleIconFile");
}

@end
