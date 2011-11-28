//
//  SCToolkit.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSTimer+Pausing.h"
#import "NSFileManager+SCAdditions.h"
#import "NSString+SCAdditions.h"

#define IS_RUNNING_LION (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6)
#define IS_RUNNING_SNOW_LEOPARD (floor(NSAppKitVersionNumber) == NSAppKitVersionNumber10_6)

#if __has_feature(objc_arc)
#define SCToolkitCopy nonatomic, strong
#define SCToolkitRetain nonatomic, strong
#define SCToolkitAssign nonatomic, weak
#else
#define SCToolkitCopy nonatomic, copy
#define SCToolkitRetain nonatomic, retain
#define SCToolkitAssign nonatomic, assign
#endif


#ifdef DEBUG

#define DebugLog(args...) _DebugLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);

#else

#define DebugLog(x...)

#endif


/**
 A drop-in replacement for NSLog
 @param 
 @returns 
 @exception 
 @copyright Karl Kraft, 2009
 @url http://www.karlkraft.com/index.php/2009/03/23/114/
 */
void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...);