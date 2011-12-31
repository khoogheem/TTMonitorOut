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

/** Support for External Displays and Projectors
 
 Allows for sending a view to an external display such as a TV or Projector via a connected cable, or using AirPlay Mirroring.  Currently picks the best output the display registers and shows the view on that display.
 
 @warning One should take into account that the view you are sending will be displayed on a larger screen and allowing to resize your view will offer a much better experiance on the external display
 */
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

///---------------------------------------------------------------------------------------
/// @name Initialization & disposal
///---------------------------------------------------------------------------------------

/** Initializes the Display with a Given UIView
 
 @param aView The UIView to send on external display.
 @return Returns initialized object.
 */
- (id)initWithView:(UIView *)aView;

/** Initializes the Display with a Given UIView
 
 @param aView The UIView to send on external display.
 @param delegate Delegate.
 @return Returns initialized object.
 @see TTMonitorOutDelegate
 */
- (id)initWithView:(UIView *)aView delegate:(id<TTMonitorOutDelegate>)delegate;

//Future - does nothing to the view controller now...
- (id)initWithViewController:(UIViewController *)aViewController;
- (id)initWithViewController:(UIViewController *)aViewController delegate:(id<TTMonitorOutDelegate>)delegate;

///---------------------------------------------------------------------------------------
/// @name Display
///---------------------------------------------------------------------------------------

/** Starts up the detection of an external display and will send the view to the best available output on that display.
 
 */
- (void)displayExternalView;

/**  Will become true when an external display is detected and the view is attached to it.
 
 @return State of the External Display.
 */
- (BOOL)externalMonitor;

@end

///---------------------------------------------------------------------------------------
/// @name Delegates
///---------------------------------------------------------------------------------------
/** TTMoitorOutDelegate 
 */
@protocol TTMonitorOutDelegate <NSObject>
@required
/** Notification of a Change in the state of the external display.  
 
 @param window The window which is being desplayed on the external display. This will be nil if the external display has been disconnected 
 */
- (void)ExternalWindowDidChange:(UIWindow *)window;
@optional
/** Notifications for debugging 
 
 @param message The debugging log messages. 
 */
- (void)logMessage:(NSString *)message;
@end
