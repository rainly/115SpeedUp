//
//  AZ115URL.h
//  115SpeedUp
//
//  Created by Aladdin on 3/7/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AZ115URL : NSObject {
	NSString * a115URLString;
	
	NSString * chinaUnicomString;
	NSString * chinaTelecomString;
	NSString * backupString;
}

@property (nonatomic, copy) NSString *a115URLString;
@property (nonatomic, copy) NSString *chinaUnicomString;
@property (nonatomic, copy) NSString *chinaTelecomString;
@property (nonatomic, copy) NSString *backupString;

@end
