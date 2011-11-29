//
//  SCGlobals.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//typedef void (^SCViewBlock)(NSView *view);
//typedef void (^SCEventBlock)(NSEvent* event);
//
//typedef void (^SCBlock)(void); // compatible with dispatch_block_t
//typedef void (^SCSenderBlock)(id sender);
//typedef void (^SCDataBlock)(NSData *data);
//typedef void (^SCErrorBlock)(NSError *error);
//typedef void (^SCIndexBlock)(NSUInteger index);
//typedef void (^SCTimeIntervalBlock)(NSTimeInterval time);
//typedef void (^SCTimerBlock)(NSTimer *timer);
//typedef void (^SCInterruptableBlock)(BOOL *stop);
//typedef void (^SCResponseBlock)(NSURLResponse *response);
//
//typedef void (^SCWithObjectBlock)(id obj, id arg);
//typedef void (^SCObservationBlock)(id obj, NSDictionary *change);
//typedef void (^SCKeyValueBlock)(id key, id obj);
//
//typedef id (^SCReturnBlock)(void);
//typedef id (^SCTransformBlock)(id obj);
//typedef id (^SCKeyValueTransformBlock)(id key, id obj);
//typedef id (^SCAccumulationBlock)(id sum, id obj);

#ifndef __has_feature
#define __has_feature(x) 0
#endif

#define IS_RUNNING_LION (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6)
#define IS_RUNNING_SNOW_LEOPARD (floor(NSAppKitVersionNumber) == NSAppKitVersionNumber10_6)

#if __has_feature(objc_arc)
#define SC_PROPERTY_COPY nonatomic, strong
#define SC_PROPERTY_RETAIN nonatomic, strong
#define SC_PROPERTY_ASSIGN nonatomic, weak
#define SC_AUTORELEASE(x) x
#else
#define SC_PROPERTY_COPY nonatomic, copy
#define SC_PROPERTY_RETAIN nonatomic, retain
#define SC_PROPERTY_ASSIGN nonatomic, assign
#define SC_AUTORELEASE(x) [x autorelease]
#endif

#ifdef DEBUG
#define DebugLog(args...) _DebugLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);
#else
#define DebugLog(x...)
#endif