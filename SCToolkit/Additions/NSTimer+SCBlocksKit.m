//
//  NSTimer+SCBlocksKit.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSTimer+SCBlocksKit.h"

@implementation NSTimer (SCBlocksKit)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo
{
    return [self scheduledTimerWithTimeInterval:seconds target:self selector:@selector(SCBlockTimer_executeBlockFromTimer:) userInfo:SC_AUTORELEASE([block copy]) repeats:yesOrNo];
}

+ (id)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo
{
    return [self timerWithTimeInterval:seconds target:self selector:@selector(SCBlockTimer_executeBlockFromTimer:) userInfo:SC_AUTORELEASE([block copy]) repeats:yesOrNo];
}

@end
