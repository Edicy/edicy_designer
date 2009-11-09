//
//  ConsoleController.m
//  Edicy Designer
//
//  Created by Priit  Haamer on 06.06.09.
//  Copyright 2009 Fraktal. All rights reserved.
//

#import "ConsoleController.h"

@interface ConsoleController (Private)
- (void)write:(NSString *)string;
- (void)processLaunchException:(NSException *)exception;
@end


@implementation ConsoleController

- (AMShellWrapper *)shellWrapper
{
	return shellWrapper;
}

- (void)setShellWrapper:(AMShellWrapper *)newShellWrapper
{
	id old = nil;
	
	if (newShellWrapper != shellWrapper) {
		old = shellWrapper;
		shellWrapper = [newShellWrapper retain];
		[old release];
	}
}


- (void)dealloc
{
	[shellWrapper release];
	[super dealloc];
}


- (void)awakeFromNib
{
	NSArray *arguments;
	
	[consoleViewer setFont:[NSFont userFixedPitchFontOfSize:0.0]];
	[consoleViewer setTextColor:[NSColor whiteColor]];

	// Switch to application directory where the Ruby script lives.
	NSBundle* bundle = [NSBundle mainBundle];
	NSString* path = [NSString stringWithFormat:@"%@/../app", [bundle bundlePath]];
	[[NSFileManager defaultManager] changeCurrentDirectoryPath:path];
	
	arguments = [@"designer.rb" componentsSeparatedByString:@" "];
	[self setShellWrapper:[[AMShellWrapper alloc] initWithController:self inputPipe:nil outputPipe:nil errorPipe:nil workingDirectory:@"." environment:nil arguments:arguments]];
	
	NS_DURING
	if (shellWrapper) {
		[shellWrapper setOutputStringEncoding:NSASCIIStringEncoding];
		[shellWrapper startProcess];
	} else {
		[self write:@"Ops! Something went wrong.\r Was not able to execute command.\r"];
	}
	NS_HANDLER
	NSLog(@"Caught %@: %@", [localException name], [localException reason]);
	[self processLaunchException:localException];
	NS_ENDHANDLER
	
}

- (void)stopTask
{
	[shellWrapper interruptProcess];
}

- (void)write:(NSString *)string
{
	NSTextStorage *text = [consoleViewer textStorage];
	[text replaceCharactersInRange:NSMakeRange([text length], 0) withString:string];
	[consoleViewer scrollRangeToVisible:NSMakeRange([text length], 0)];
}

// ============================================================
// conforming to the AMShellWrapperController protocol:
// ============================================================

// output from stdout
- (void)appendOutput:(NSString *)output
{
	[self write:output];
}

// output from stderr
- (void)appendError:(NSString *)error
{
	[self write:error];
}

// This method is a callback which your controller can use to do other initialization
// when a process is launched.
- (void)processStarted:(id)sender
{
	//[progressIndicator startAnimation:self];
	//[runButton setTitle:@"Stop"];
	//[runButton setAction:@selector(stopTask:)];
	//NSURL *url = [NSURL URLWithString:@"http://localhost:9494"];
	//[[NSWorkspace sharedWorkspace] openURL:url];
}

// This method is a callback which your controller can use to do other cleanup
// when a process is halted.
- (void)processFinished:(id)sender withTerminationStatus:(int)resultCode
{
	[self write:[NSString stringWithFormat:@"\rcommand finished. Result code: %i\r", resultCode]];
	[self setShellWrapper:nil];
	[consoleViewer scrollRangeToVisible:NSMakeRange([[consoleViewer string] length], 0)];
	//[errorOutlet scrollRangeToVisible:NSMakeRange([[errorOutlet string] length], 0)];
	//[runButton setEnabled:YES];
	//[progressIndicator stopAnimation:self];
	[sender release];
	//[runButton setTitle:@"Execute"];
	//[runButton setAction:@selector(printBanner:)];
}

- (void)processLaunchException:(NSException *)exception
{
	[self write:[NSString stringWithFormat:@"\rcaught %@ while executing command\r", [exception name]]];
	[consoleViewer scrollRangeToVisible:NSMakeRange([[consoleViewer string] length], 0)];
	//[errorOutlet scrollRangeToVisible:NSMakeRange([[errorOutlet string] length], 0)];
	//[runButton setEnabled:YES];
	//[progressIndicator stopAnimation:self];
	//[runButton setTitle:@"Execute"];
	//[runButton setAction:@selector(printBanner:)];
	[self setShellWrapper:nil];
}



@end
