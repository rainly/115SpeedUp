//
//  AZ115URL.m
//  115SpeedUp
//
//  Created by Aladdin on 3/7/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import "AZ115URL.h"
#import <JSON/JSON.h>

@implementation AZ115URL

@synthesize a115URLString;
@synthesize chinaUnicomString;
@synthesize chinaTelecomString;
@synthesize backupString;
#define UeggVersion 1169
- (void)getURLsFrom115ApiWithURL:(NSString*)aurl{
	self.a115URLString = aurl;
	NSString * pickcode = [a115URLString lastPathComponent];
	NSString * apiURL = [NSString stringWithFormat:@"http://u.115.com/?ct=upload_api&ac=get_pick_code_info&pickcode=%@&version=%d",pickcode,UeggVersion];
	NSString * retStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:apiURL] encoding:NSUTF8StringEncoding error:nil];
	NSDictionary * retDict = [retStr JSONValue];
	NSArray * downloadUrls = [retDict objectForKey:@"DownloadUrl"];
	self.chinaUnicomString = [[downloadUrls objectAtIndex:0] objectForKey:@"Url"];
	self.chinaTelecomString =[[downloadUrls objectAtIndex:1] objectForKey:@"Url"]; 
	self.backupString = [[downloadUrls objectAtIndex:2] objectForKey:@"Url"];
	NSLog(@"%@",retDict);
}
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
