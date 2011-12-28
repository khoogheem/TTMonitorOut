//
//  TTMonitorOut.m
//  
//
//  Created by Kevin Hoogheem on 12/2/11.
//  Copyright (c) 2011 Kevin A. Hoogheem. All rights reserved.
//

#import "TTMonitorOut.h"

@interface TTMonitorOut (PrivateMethods)
-(void)installNotificationObservers;
-(void)removeNotificationHandlers;
@end

@implementation TTMonitorOut
@synthesize delegate;
@synthesize externalViewController;
@synthesize externalView;


- (BOOL)externalMonitor
{
	return (externalWindow == nil) ? FALSE : TRUE;
}

#pragma mark
#pragma mark - Screen

- (void)screenDidChange:(NSNotification *)notification
{
	NSArray			*screens;
	UIScreen		*aScreen;
	UIScreenMode	*mode;
	
	// 1.	
	// Log the current screens and display modes
	screens = [UIScreen screens];
	
	if ([delegate respondsToSelector:@selector(logMessage:)]) {
		[self.delegate logMessage:[NSString stringWithFormat:@"Device has %d screen(s).\n", [screens count]]];
	}
	
	
	uint32_t screenNum = 1;
	for (aScreen in screens) {			  
		NSArray *displayModes;
		
		displayModes = [aScreen availableModes];
		for (mode in displayModes) {
			if ([delegate respondsToSelector:@selector(logMessage:)]) {
				[self.delegate logMessage:[NSString stringWithFormat:@"\tScreen (%d) mode: %@\n", screenNum, mode]];
			}
		}
		
		screenNum++;
	}
	
	
	NSUInteger screenCount = [screens count];
	
	if (screenCount > 1) {
		// 2.
		// Select first external screen
		externalScreen = [screens objectAtIndex:1];
		//self.availableModes = [extScreen availableModes];
		
		if (externalWindow == nil || !CGRectEqualToRect(externalWindow.bounds, [externalScreen bounds])) {
			// Size of window has actually changed
			
			// 4.
			// Create a new window object
			externalWindow = [[UIWindow alloc] initWithFrame:[externalScreen bounds]];
			
			// 5.
			// Assign the screen object
			externalWindow.screen = externalScreen;
			
			UIView *view = [[UIView alloc] initWithFrame:[externalWindow frame]];
			view.backgroundColor = [UIColor whiteColor];
			
			[externalWindow addSubview:view];
			[view release];
			
			// 6.	
			// Configure the window
			externalView.frame = externalWindow.frame;
						
			[externalWindow addSubview:externalView];
			
			// 7.
			// Show the window
			[externalWindow makeKeyAndVisible];
			
			// Inform delegate that the external window has been created.
			if ([delegate respondsToSelector:@selector(logMessage:)]) {
				[delegate logMessage:[NSString stringWithFormat:@"External View Created.\n"]];
			}

			[self.delegate ExternalWindowDidChange:externalWindow];

		}
		
	}
	else {
		if ([delegate respondsToSelector:@selector(logMessage:)]) {
			[delegate logMessage:[NSString stringWithFormat:@"\tExternal View Removed.\n"]];
		}
		
		// Release external screen and window
		externalScreen = nil;
		externalWindow = nil;
		
		// Inform delegate that the external window has been removed.
		[self.delegate ExternalWindowDidChange:externalWindow];		
		
	}
}



#pragma mark
#pragma mark - Notifications
-(void)installNotificationObservers
{
	// No notifications are sent for screens that are present when the app is launched.
	[self screenDidChange:nil];
	
	// Register for screen connect and disconnect notifications.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(screenDidChange:)
												 name:UIScreenDidConnectNotification 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(screenDidChange:)
												 name:UIScreenDidDisconnectNotification 
											   object:nil];
	
	
}

-(void)removeNotificationHandlers
{    
    
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIScreenDidConnectNotification 
												  object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIScreenDidDisconnectNotification 
												  object:nil];
}

#pragma mark
#pragma mark Inits

- (void)displayExternalView
{
	if ([delegate respondsToSelector:@selector(logMessage:)]) {
		[self.delegate logMessage:@"Starting External Window Display\n"];
	}
	
	[self installNotificationObservers];
}

- (id)initWithView:(UIView  *)aView delegate:(id<TTMonitorOutDelegate>)adelegate
{
	if ([delegate respondsToSelector:@selector(logMessage:)]) {
		[self.delegate logMessage:[NSString stringWithFormat:@"\t in initWithView.\n"]];
	}
	
	self = [super init];
	if (self){	
		self.externalView = aView;
		self.delegate = adelegate;
	}
	
	return self;

}

- (id)initWithView:(UIView *)aView
{
	return [self initWithView:aView delegate:nil];
}

- (id)initWithViewController:(UIViewController *)aViewController delegate:(id<TTMonitorOutDelegate>)adelegate
{
	return [self initWithView:aViewController.view delegate:adelegate];
}

- (id)initWithViewController:(UIViewController *)aViewController
{		
	return [self initWithViewController:aViewController delegate:nil];
}

/*
-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	[super dealloc];
}
*/

@end
