//
//  NSApplication+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/30/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSApplication (SCAdditions)

/** Get current Mac OS X system version
 @param major the major version. For example 10.5, 10.6
 @param minor the minor version. For example 10.5.8, the 8 is the minor version
 @returns 
 @exception 
 */
- (void)sc_getSystemVersionMajor:(unsigned *)major minor:(unsigned *)minor bugFix:(unsigned *)bugFix;

@end
