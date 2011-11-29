//
//  NSTimer+SCBlocksKit.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSTimer+SCBlocksKit.h"

typedef void(^SCTimerBlock)(NSTimer *);

@interface SCTimerBlockHandler : NSObject {
    id block;
}
@property (SC_RETAIN) id block;
- (void)sc_handleBlockWithTimer:(NSTimer *)timer;
- (void)sc_handleBlockWithInterruptableTimer:(NSTimer *)timer;
@end

@interface NSTimer (SCBlocksTimerPrivate)
+ (void)SCBlockTimer_executeBlockFromTimer:(NSTimer *)aTimer;
@end

@implementation NSTimer (SCBlocksKit)

+ (id)sc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo
{
    return [self scheduledTimerWithTimeInterval:seconds target:self selector:@selector(SCBlockTimer_executeBlockFromTimer:) userInfo:SC_AUTORELEASE([block copy]) repeats:yesOrNo];
}

+ (id)sc_timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo
{
    return [self timerWithTimeInterval:seconds target:self selector:@selector(SCBlockTimer_executeBlockFromTimer:) userInfo:SC_AUTORELEASE([block copy]) repeats:yesOrNo];
}

+ (NSTimer *)sc_scheduledInterruptableTimerWithTimeInterval:(NSTimeInterval)seconds blockHandler:(void (^)(BOOL *stop))block
{
	SCTimerBlockHandler *blockHandler = [[SCTimerBlockHandler alloc] init];
	blockHandler.block = [block copy];
	
    return [self scheduledTimerWithTimeInterval:seconds target:blockHandler selector:@selector(jcs_handleBlockWithInterruptableTimer:) userInfo:nil repeats:YES];
}

@end

@implementation SCTimerBlockHandler

@synthesize block;

- (void)sc_handleBlockWithInterruptableTimer:(NSTimer *)timer 
{
    
    JCSInterruptableTimerCallback callbackBlock = self.block;
    
    BOOL stop;
    callbackBlock(&stop);
    
    if (stop) {
        [timer invalidate];
        timer = nil;
    }
}

@end


@implementation NSTimer (SCBlocksTimerPrivate)

+ (void)SCBlockTimer_executeBlockFromTimer:(NSTimer *)aTimer;
{
    //  SCTimerBlock block = [aTimer userInfo];
    if([aTimer isValid]) {
        SCTimerBlock block = [aTimer userInfo];
        block(aTimer);
    }
}

@end