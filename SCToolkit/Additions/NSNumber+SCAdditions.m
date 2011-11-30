//
//  NSNumber+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSNumber+SCAdditions.h"

@implementation NSNumber (SCAdditions)

+ (NSNumber *)sc_numberWithString:(NSString *)aString
{
    NSNumber *result = nil;
    if (aString && ![aString isEqualToString:@""]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        result = [f numberFromString:aString];
        [f release];
    }
	
	return result;
}

@end
