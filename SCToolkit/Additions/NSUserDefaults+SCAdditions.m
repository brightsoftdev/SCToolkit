//
//  NSUserDefaults+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 12/2/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSUserDefaults+SCAdditions.h"

@implementation NSUserDefaults (SCAdditions)

+ (void)sc_reset
{
	[[self standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
	[[self standardUserDefaults] synchronize];
}

@end
