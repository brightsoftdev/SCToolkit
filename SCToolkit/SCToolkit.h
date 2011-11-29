//
//  SCToolkit.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#ifndef __has_feature
#define __has_feature(x) 0
#endif

#define IS_RUNNING_LION (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6)
#define IS_RUNNING_SNOW_LEOPARD (floor(NSAppKitVersionNumber) == NSAppKitVersionNumber10_6)

#if __has_feature(objc_arc)
#define SC_COPY nonatomic, strong
#define SC_RETAIN nonatomic, strong
#define SC_ASSIGN nonatomic, weak
#define SC_AUTORELEASE(x) x
#else
#define SC_COPY nonatomic, copy
#define SC_RETAIN nonatomic, retain
#define SC_ASSIGN nonatomic, assign
#define SC_AUTORELEASE(x) [x autorelease]
#endif


#ifdef DEBUG

#define DebugLog(args...) _DebugLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);

#else

#define DebugLog(x...)

#endif

#import <Cocoa/Cocoa.h>
#import <dispatch/dispatch.h>
#import <objc/runtime.h>
#import "NSTimer+Pausing.h"
#import "NSFileManager+SCAdditions.h"
#import "NSString+SCAdditions.h"

#import "AMSerialErrors.h"
#import "AMSerialPort.h"
#import "AMSerialPortAdditions.h"
#import "AMSerialPortList.h"

#import "NSTimer+SCBlocksKit.h"
#import "NSObject+SCBlocksKit.h"

/** A drop-in replacement for NSLog
 @param 
 @returns 
 @exception 
 @copyright Karl Kraft, 2009
 @url http://www.karlkraft.com/index.php/2009/03/23/114/
 */
void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...);