//
//  _15SpeedUpAppDelegate.m
//  115SpeedUp
//
//  Created by Aladdin on 3/7/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import "_15SpeedUpAppDelegate.h"

@implementation _15SpeedUpAppDelegate

@synthesize downloadBtn;
@synthesize progress;
@synthesize progressIndicator;
@synthesize chinaUnicomBtn;
@synthesize chinaTelecomBtn;
@synthesize backupBtn;
@synthesize az115URL;
@synthesize a115urlText;
@synthesize window;

- (void)dealloc
{
	[a115urlText release];
	a115urlText = nil;

	[az115URL release];
	az115URL = nil;

	[chinaUnicomBtn release];
	chinaUnicomBtn = nil;
	[chinaTelecomBtn release];
	chinaTelecomBtn = nil;
	[backupBtn release];
	backupBtn = nil;

	[progressIndicator release];
	progressIndicator = nil;


	[downloadBtn release];
	downloadBtn = nil;

	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	[self.a115urlText becomeFirstResponder];
	self.az115URL = [[AZ115URL alloc] init];
	[self updateBtns:nil];
	[self.progressIndicator setHidden:YES];
}

- (NSString*)fileNameFromUrl:(NSString *)url{
	NSArray * a1 = [url	componentsSeparatedByString:@"?"];
	NSArray * a2 = [[a1 objectAtIndex:1] componentsSeparatedByString:@"&"];

	NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:4];
	for(int i = 0;i <[a2 count];i++){
		NSArray * a3 = [[a2 objectAtIndex:i] componentsSeparatedByString:@"="];
		[dic setObject:[a3 objectAtIndex:1] forKey:[a3 objectAtIndex:0]];		
	}

	
	return [dic objectForKey:@"file"];
}
#pragma mark textfield delegate
- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor{
	[self getUrl:control];
	return YES;
}
- (IBAction)getUrl:(id)sender{
	[self.az115URL getURLsFrom115ApiWithURL:[self.a115urlText stringValue]];
	[self updateBtns:sender];
}
- (void)updateBtns:(id)sender{
	if ([self.az115URL.chinaUnicomString length]>4) {
		[self.chinaUnicomBtn setEnabled:YES];
	}else {
		[self.chinaUnicomBtn setEnabled:NO];
	}
	if ([self.az115URL.chinaTelecomString length]>4) {
		[self.chinaTelecomBtn setEnabled:YES];
	}else {
		[self.chinaTelecomBtn setEnabled:NO];
	}
	if ([self.az115URL.backupString length]>4) {
		[self.backupBtn setEnabled:YES];
	}else {
		[self.backupBtn setEnabled:NO];
	}
}
- (IBAction)download:(id)sender{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSTask * task = [[NSTask alloc] init];
	[task setLaunchPath:[[NSBundle mainBundle] pathForResource:@"axel" ofType:nil]];
	NSMutableArray * args = [NSMutableArray arrayWithObjects:@"-n",@"100",nil];
	[self.progressIndicator setHidden:NO];
	self.progress = 0;
	[self.a115urlText resignFirstResponder];
	[self.a115urlText setEnabled:NO];
	[self.a115urlText setEditable:NO];

	[self disableAllDownload:nil];
	NSButton * btn = (NSButton *)sender;
	[btn setEnabled:YES];
	[self changeToCancelBtn:btn];
	switch (btn.tag) {
		case 1:
		{
			[args addObject:@"-o"];
			[args addObject:[NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Downloads"],[self fileNameFromUrl:self.az115URL.chinaUnicomString]]];
			[args addObject:self.az115URL.chinaUnicomString];
		}
			
			break;
		case 2:
			
		{
			[args addObject:@"-o"];
			[args addObject:[NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Downloads"],[self fileNameFromUrl:self.az115URL.chinaTelecomString]]];
			[args addObject:self.az115URL.chinaTelecomString];
		}
			break;
		case 3:
			
		{
			[args addObject:@"-o"];
			[args addObject:[NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Downloads"],[self fileNameFromUrl:self.az115URL.backupString]]];
			[args addObject:self.az115URL.backupString];
		}
			break;
		default:
			break;
	}
	NSLog(@"%@",args);
	[task setArguments:args];

	NSPipe * outPipe = [[NSPipe alloc]init];
	[task setStandardOutput:outPipe];
	
	NSFileHandle * outFileHandle = [outPipe fileHandleForReading];
	[task launch];

	while (1) {
		[NSThread sleepUntilDate: [NSDate dateWithTimeIntervalSinceNow:1]];
		NSData * data = [outFileHandle availableData];
		if ([data length]>0) {
			NSString * errs = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
			NSArray * infos = [errs componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
			for (NSString * info in infos){
				if ([info length]>12) {
					NSString * prefixStr = [info substringToIndex:6];
					if ([prefixStr hasPrefix:@"["]&&[prefixStr hasSuffix:@"]"]) {
						//NSLog(@"progress prefix string %@",prefixStr);
						self.progress = [[prefixStr substringWithRange:NSMakeRange(1, 3)] intValue];
					}
					NSString * suffixStr = [info substringWithRange:NSMakeRange([info length]-12, 12)];
					if ([suffixStr hasPrefix:@"["]&&[suffixStr hasSuffix:@"]"]) {
						NSLog(@"%@",suffixStr);
//						[downloadBtn setTitle:suffixStr];
						NSFont *font = [NSFont systemFontOfSize:12.0];
						NSDictionary *attrsDictionary =
						[NSDictionary dictionaryWithObject:font
													forKey:NSFontAttributeName];
						NSAttributedString *attrString =
						[[NSAttributedString alloc] initWithString:[suffixStr substringWithRange:NSMakeRange(1, 10)]
														attributes:attrsDictionary];
						[downloadBtn setAttributedTitle:attrString];
					}
				}
			}
			[self.progressIndicator setDoubleValue:self.progress];
			if (self.progress == 100) {
				break;
			}
		}
	}
	[self.a115urlText setValue:@""];
	[self enableAllDownload:YES];
	[self updateBtns:nil];
	[self changeToNormalBtn:btn];
	[pool release];	
}
- (void)changeToCancelBtn:(NSButton*)btn{
	[btn setTitle:@"取消下载"];
}
- (void)changeToNormalBtn:(NSButton *)btn{

	switch (btn.tag) {
		case 1:
			[btn setTitle:@"网通下载"];
			break;
		case 2:
			[btn setTitle:@"电信下载"];
			break;
		case 3:
			[btn setTitle:@"备份下载"];
			break;
		default:
			break;
	}
}
- (void)disableAllDownload:(id)sender{
	[self.chinaUnicomBtn setEnabled:NO];
	[self.chinaTelecomBtn setEnabled:NO];
	[self.backupBtn setEnabled:NO];
}
- (void)enableAllDownload:(id)sender{
	[self.chinaUnicomBtn setEnabled:YES];
	[self.chinaTelecomBtn setEnabled:YES];
	[self.backupBtn setEnabled:YES];
}
- (IBAction)dataUpdate:(id)sender{
	[self.downloadBtn setEnabled:NO];
	[NSThread detachNewThreadSelector:@selector(download:) toTarget:self withObject:sender];
}
@end
