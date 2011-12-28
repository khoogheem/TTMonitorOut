//
//  TTMonitorOut.h
//  
//
//  Created by Kevin Hoogheem on 12/2/11.
//  Copyright (c) 2011 Kevin A. Hoogheem. All rights reserved.
//
/*
Support for External Displays and Projectors

iPad, iPhone 4 and later, and iPod touch (4th generation) and later can now be connected to an external display
through a supported cable. Applications can use this connection to present content in addition to the content
on the device’s main screen. Depending on the cable, you can output content at up to a 720p (1280 x 720)
resolution. A resolution of 1024 by 768 resolution may also be available if you prefer to use that aspect ratio.

To display content on an external display, do the following:

1. Use the screens class method of the UIScreen class to determine if an external display is available.

2. If an external screen is available, get the screen object and look at the values in its availableModes
property. This property contains the configurations supported by the screen.

3. Select the UIScreenMode object corresponding to the desired resolution and assign it to the currentMode
property of the screen object.

4. Create a new window object (UIWindow) to display your content.

5. Assign the screen object to the screen property of your new window.

6. Configure the window (by adding views or setting up your OpenGL ES rendering context).

7. Show the window.

Important: You should always assign a screen object to your window before you show that window. Although you 
can change the screen while a window is already visible, doing so is an expensive operation and not recommended.
Screen mode objects identify a specific resolution supported by the screen. Many screens support multiple
resolutions, some of which may include different pixel aspect ratios. The decision for which screen mode to use
should be based on performance and which resolution best meets the needs of your user interface. When you are
ready to start drawing, use the bounds provided by the UIScreen object to get the proper size for rendering
your content. The screen’s bounds take into account any aspect ratio data so that you can focus on drawing your content.

If you want to detect when screens are connected and disconnected, you can register to receive screen
connection and disconnection notifications. For more information about screens and screen notifications, see
UIScreen Class Reference. For information about screen modes, see UIScreenMode Class Reference.

*/

#import <Foundation/Foundation.h>

@protocol TTMonitorOutDelegate;

@interface TTMonitorOut : NSObject
{
	id <TTMonitorOutDelegate>	delegate;
	UIViewController			*externalViewController;
	UIView						*externalView;
	
@private
	UIScreen					*externalScreen;
	UIWindow					*externalWindow;
}

@property (nonatomic, assign) id <TTMonitorOutDelegate> delegate;
@property (nonatomic, retain) UIViewController	*externalViewController;
@property (nonatomic, retain) UIView			*externalView;

- (id)initWithView:(UIView *)aView;
- (id)initWithView:(UIView  *)aView delegate:(id<TTMonitorOutDelegate>)adelegate;

//Future - does nothing to the view controller now...
- (id)initWithViewController:(UIViewController *)aViewController;
- (id)initWithViewController:(UIViewController *)aViewController delegate:(id<TTMonitorOutDelegate>)delegate;


- (void)displayExternalView;
- (BOOL)externalMonitor;

@end

@protocol TTMonitorOutDelegate <NSObject>
@required
- (void)ExternalWindowDidChange:(UIWindow *)window;
@optional
- (void)logMessage:(NSString *)message;
@end
