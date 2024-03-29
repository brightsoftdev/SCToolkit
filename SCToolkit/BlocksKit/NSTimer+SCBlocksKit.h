//
//  NSTimer+SCBlocksKit.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SCBlocksKit)

+ (id)sc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo;
+ (id)sc_timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo;

/** An NSTimer Extension that runs a block when the timer is fired.
 
 Blocks are frequently more convenient to use instead of callbacks. They appear in the same context as the code that calls
 them and, and it's easier to pass state information to them at the same time.
 
 This extension creates two methods, one which creates an optionally repeating timer which fires a block, and the other creates
 a repeating timer but passes a reference to a stop parameter to the block so the timer can be stopped from within the block.
 
 @warning This code uses a macro, ZAssert, which requires that you make additions to your Project's PCH file.
 You can get these macros from [http://gist.github.com/325926](http://gist.github.com/325926) which also contains links to show
 you how they are used.
 
 */

typedef void (^JCSInterruptableTimerCallback)(BOOL *stop);

/** Create a repeating timer which can be stopped from within the passed block
 
 @return An NSTimer that will fire events as configured.
 @param seconds NSInterval. The number of seconds between the the firing of the timer.
 @param block A block which has a void return but has a `BOOL *stop` parameter.
 
 Setting this parameter to `NO` from within the block will prevent any more events to be fired by the timer. 
 Additionally, the timer will be invalidated and set to nil when it is stopped this way.
 
 The type is JCSInterruptableTimerCallback which is defined as 
 
 typedef void (^JCSInterruptableTimerCallback)(BOOL *stop);
 
 */
+ (NSTimer *)sc_scheduledInterruptableTimerWithTimeInterval:(NSTimeInterval)seconds blockHandler:(void (^)(BOOL *stop))block;

@end
