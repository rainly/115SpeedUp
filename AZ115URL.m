//
//  AZ115URL.m
//  115SpeedUp
//
//  Created by Aladdin on 3/7/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import "AZ115URL.h"


@implementation AZ115URL

@synthesize a115URLString;
@synthesize chinaUnicomString;
@synthesize chinaTelecomString;
@synthesize backupString;

- (void)dealloc
{
	[a115URLString release];
	a115URLString = nil;
	[chinaUnicomString release];
	chinaUnicomString = nil;
	[chinaTelecomString release];
	chinaTelecomString = nil;
	[backupString release];
	backupString = nil;

	[super dealloc];
}

@end
