//
//  AppDelegate.m
//  Edicy Designer
//
//  Created by Priit  Haamer on 06.06.09.
//  Copyright 2009 Fraktal. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

//	applicationShouldTerminateAfterLastWindowClosed:sender
//
//	NSApplication delegate method placed here so the sample conveniently quits
//	after we close the window.
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)sender
{
	return YES;
}

//	applicationDidFinishLaunching:notification
- (void)applicationDidFinishLaunching:(NSNotification*)notification
{
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	[consoleController stopTask];
}
@end
