//
//  NSTimer+Pausing.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSTimer+Pausing.h"

NSString *kIsPausedKey				= @"BS IsPaused Key";
NSString *kRemainingTimeIntervalKey	= @"BS RemainingTimeInterval Key";

@interface NSTimer (SCPausing_Private)

- (NSMutableDictionary *)_pauseDictionary;

@end

@implementation NSTimer (SCPausing_Private)

- (NSMutableDictionary *)_pauseDictionary
{
	static NSMutableDictionary *globalDictionary = nil;
	
	// Create a global dictionary for all instances
	if(!globalDictionary)
		globalDictionary = [[NSMutableDictionary alloc] init];
	
	// Create a local dictionary for this instance
	if(![globalDictionary objectForKey:[NSNumber numberWithInt:(int)self]])
	{
		NSMutableDictionary *localDictionary = [[[NSMutableDictionary alloc] init] autorelease];
		[globalDictionary setObject:localDictionary forKey:[NSNumber numberWithInt:(int)self]];
	}
	
	// Return the local dictionary
	return [globalDictionary objectForKey:[NSNumber numberWithInt:(int)self]];
}

@end

@implementation NSTimer (SCPausing)

- (void)sc_pause
{
	// Prevent invalid timers from being paused
	if(![self isValid])
		return;
	
	// Prevent paused timers from being paused again
	NSNumber *isPausedNumber = [[self _pauseDictionary] objectForKey:kIsPausedKey];
	if(isPausedNumber && YES == [isPausedNumber boolValue])
		return;
	
	// Calculate remaining time interval
	NSDate *now		= [NSDate date];
	NSDate *then	= [self fireDate];
	NSTimeInterval remainingTimeInterval = [then timeIntervalSinceDate:now];
	
	// Store remaining time interval
	[[self _pauseDictionary] setObject:[NSNumber numberWithDouble:remainingTimeInterval] forKey:kRemainingTimeIntervalKey];
	
	// Pause timer
	[self setFireDate:[NSDate distantFuture]];
	[[self _pauseDictionary] setObject:[NSNumber numberWithBool:YES] forKey:kIsPausedKey];
}

- (void)sc_resume
{
	// Prevent invalid timers from being resumed
	if(![self isValid])
		return;
	
	// Prevent paused timers from being paused again
	NSNumber *isPausedNumber = [[self _pauseDictionary] objectForKey:kIsPausedKey];
	if(!isPausedNumber || NO == [isPausedNumber boolValue])
		return;
	
	// Load remaining time interval
	NSTimeInterval remainingTimeInterval = [[[self _pauseDictionary] objectForKey:kRemainingTimeIntervalKey] doubleValue];
	
	// Calculate new fire date
	NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:remainingTimeInterval];
	
	// Resume timer
	[self setFireDate:fireDate];
	[[self _pauseDictionary] setObject:[NSNumber numberWithBool:NO] forKey:kIsPausedKey];
}

@end
