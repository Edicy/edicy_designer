//
//  ConsoleController.h
//  Edicy Designer
//
//  Created by Priit  Haamer on 06.06.09.
//  Copyright 2009 Fraktal. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AMShellWrapper.h"


@interface ConsoleController : NSWindowController <AMShellWrapperController> {
	IBOutlet NSTextView *consoleViewer;
	IBOutlet NSButton *stopButton;
	AMShellWrapper *shellWrapper;
}

- (AMShellWrapper *)shellWrapper;
- (void)setShellWrapper:(AMShellWrapper *)newShellWrapper;

- (void)stopTask;

// ============================================================
// conforming to the AMShellWrapperController protocol:
// ============================================================

- (void)appendOutput:(NSString *)output;
// output from stdout

- (void)appendError:(NSString *)error;
// output from stderr

- (void)processStarted:(id)sender;
// This method is a callback which your controller can use to do other initialization
// when a process is launched.

- (void)processFinished:(id)sender withTerminationStatus:(int)resultCode;
// This method is a callback which your controller can use to do other cleanup
// when a process is halted.



@end
