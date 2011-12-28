//
//  ViewController.h
//  SampleTVOut
//
//  Created by Kevin Hoogheem on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTMonitorOut.h"
#import "MyMovieViewController.h"

@interface ViewController : UIViewController <TTMonitorOutDelegate, NSStreamDelegate>{

	MyMovieViewController *movieController;
	UISwitch *toggleMoviePlaybackSwitch;
}

@property (nonatomic, retain) IBOutlet UITextView *consoleLog;
@property (nonatomic, retain) IBOutlet UISwitch *toggleMoviePlaybackSwitch;
-(IBAction)ChangeMovieState;

@end
