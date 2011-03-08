//
//  _15SpeedUpAppDelegate.h
//  115SpeedUp
//
//  Created by Aladdin on 3/7/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AZ115URL.h"
@interface _15SpeedUpAppDelegate : NSObject <NSApplicationDelegate,NSTextFieldDelegate> {
    NSWindow *window;
	NSTextField * a115urlText;
	AZ115URL * az115URL;
	
	NSButton * chinaUnicomBtn;
	NSButton * chinaTelecomBtn;
	NSButton * backupBtn;
	
	NSButton * downloadBtn;
	
	NSLevelIndicator * progressIndicator;
	
	NSInteger progress;
}

@property (nonatomic, retain) IBOutlet NSButton *downloadBtn;
@property (nonatomic, assign) IBOutlet NSInteger progress;
@property (nonatomic, retain) IBOutlet NSLevelIndicator *progressIndicator;
@property (nonatomic, retain) IBOutlet NSButton *chinaUnicomBtn;
@property (nonatomic, retain) IBOutlet NSButton *chinaTelecomBtn;
@property (nonatomic, retain) IBOutlet NSButton *backupBtn;
@property (nonatomic, retain) AZ115URL *az115URL;
@property (nonatomic, retain) IBOutlet NSTextField *a115urlText;
@property (assign) IBOutlet NSWindow *window;
- (IBAction)getUrl:(id)sender;
- (void)updateBtns:(id)sender;
- (IBAction)download:(id)sender;
- (IBAction)dataUpdate:(id)sender;
- (void)disableAllDownload:(id)sender;
- (void)enableAllDownload:(id)sender;
@end