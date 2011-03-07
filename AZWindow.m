//
//  AZWindow.m
//  115SpeedUp
//
//  Created by Aladdin on 3/7/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import "AZWindow.h"


@implementation AZWindow
- (void) awakeFromNib
{
    [self registerForDraggedTypes: [NSArray arrayWithObjects: NSFilenamesPboardType,NSURLPboardType, nil]];
}

- (NSDragOperation) draggingEntered: (id < NSDraggingInfo >) sender
{
		NSLog(@"%s,%@",_cmd,sender);
    NSPasteboard *pboard = [sender draggingPasteboard];
    NSDragOperation opType = NSDragOperationNone;
	
    if ([[pboard types] containsObject: NSFilenamesPboardType])
        opType = NSDragOperationCopy;
	
    return opType;
}

- (BOOL) performDragOperation: (id < NSDraggingInfo >) sender
{
	NSLog(@"%s,%@",_cmd,sender);
    NSPasteboard *pboard = [sender draggingPasteboard];
    BOOL successful = NO;
	
    if ([[pboard types] containsObject: NSFilenamesPboardType])
    {
        NSArray *files = [pboard propertyListForType: NSFilenamesPboardType];
		//  [controller startConversion: [files objectAtIndex: 0]];
		NSLog(@"%@",files);
        successful = YES;
    }
	
    return successful;
}
@end
