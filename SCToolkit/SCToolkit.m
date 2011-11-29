//
//  SCToolkit.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "SCToolkit.h"

NSString *const SCToolkitException = @"SCToolkitException";

void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...) 
{
    va_list ap;
	
    va_start (ap, format);
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
	}
	NSString *body =  [[NSString alloc] initWithFormat: format arguments: ap];
	va_end (ap);
	const char *threadName = [[[NSThread currentThread] name] UTF8String];
    NSString *fileName=[[NSString stringWithUTF8String:file] lastPathComponent];
	if (threadName) {
		fprintf(stderr,"%s/%s (%s:%d) %s",threadName,funcName,[fileName UTF8String],lineNumber,[body UTF8String]);
	} else {
		fprintf(stderr,"%p/%s (%s:%d) %s",[NSThread currentThread],funcName,[fileName UTF8String],lineNumber,[body UTF8String]);
	}
	[body release];	
}
