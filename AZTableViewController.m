//
//  AZTableViewController.m
//  115SpeedUp
//
//  Created by Aladdin on 3/8/11.
//  Copyright 2011 innovation-works. All rights reserved.
//

#import "AZTableViewController.h"


@implementation AZTableViewController

@synthesize downloadArray;
@synthesize listTableView;
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
	return [downloadArray count];
}
- (void)dealloc
{
	[listTableView release];
	listTableView = nil;

	[downloadArray release];
	downloadArray = nil;

	[super dealloc];
}

@end
