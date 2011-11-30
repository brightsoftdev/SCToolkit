//
//  NSBundle+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/30/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (SCAdditions)

/** The Info.plist CFBundleIconFile, preloaded and cached into an NSImage.
 @param 
 @returns 
 @exception 
 */

- (NSImage *)sc_icon;

@end
