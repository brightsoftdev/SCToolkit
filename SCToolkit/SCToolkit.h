//
//  SCToolkit.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

extern NSString *const SCToolkitException;

#import "SCGlobals.h"

// Fundation

#import "NSNumber+SCAdditions.h"
#import "NSData+SCAdditions.h"
#import "NSTimer+Pausing.h"
#import "NSFileManager+SCAdditions.h"
#import "NSWorkspace+SCAdditions.h"
#import "NSString+SCAdditions.h"
#import "NSImage+SCAdditions.h"
#import "NSArray+SCAdditions.h"
#import "NSMutableArray+SCAdditions.h"
#import "NSBundle+SCAdditions.h"
#import "NSApplication+SCAdditions.h"


// Third Party

#import "INAppStoreWindow.h"
#import "ESCursors.h"

#import "NSView+JAExtensions.h"
#import "NSObject+JAExtensions.h"
#import "JAViewController.h"

#import "PXNavigationBar.h"

#import "AMSerialErrors.h"
#import "AMSerialPort.h"
#import "AMSerialPortAdditions.h"
#import "AMSerialPortList.h"

// AppKit
#import "NSBezierPath+SCAdditions.h"
#import "NSBezierPath+SCAdditions.h"
#import "NSView+SCAdditions.h"
#import "NSWindow+SCAdditions.h"

#import "SCSelectionBorder.h"
#import "SCHybridPopoverController.h"

// Utilities
#import "SCTimerFormatter.h"






//#import "NSTimer+SCBlocksKit.h"
//#import "NSObject+SCBlocksKit.h"

/** A drop-in replacement for NSLog
 @param 
 @returns 
 @exception 
 @copyright Karl Kraft, 2009
 @url http://www.karlkraft.com/index.php/2009/03/23/114/
 */
void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...);

/** Given two corners, make an NSRect.
 @param p1 NSPoint
 @param p2 NSPoint
 @returns 
 @exception 
 */
inline NSRect _RectFromPoints(NSPoint p1, NSPoint p2);