//
//  SCToolkit.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//


#import "NSTimer+Pausing.h"
#import "NSFileManager+SCAdditions.h"
#import "NSString+SCAdditions.h"

#import "AMSerialErrors.h"
#import "AMSerialPort.h"
#import "AMSerialPortAdditions.h"
#import "AMSerialPortList.h"

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