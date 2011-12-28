//
//  ViewController.m
//  SampleTVOut
//
//  Created by Kevin Hoogheem on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize consoleLog;
@synthesize toggleMoviePlaybackSwitch;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma 
#pragma mark - TTMonitor Delegates
- (void)logMessage:(NSString *)response
{	
	consoleLog.text = [self.consoleLog.text stringByAppendingString:response];
	
	[consoleLog scrollRangeToVisible:NSMakeRange([consoleLog.text length], 0)];

}


-(void)ExternalWindowDidChange:(UIWindow*)window{	
	
	[self logMessage:[NSString stringWithFormat:@"External window %@\n", window] ];

	if (window == nil){
		
		[self logMessage:[NSString stringWithFormat:@"External window %@\n Do something with display\n", window] ];

		[movieController pauseMovieStream];
		toggleMoviePlaybackSwitch.on = FALSE;
		
	}else
	{
		[self logMessage:[NSString stringWithFormat:@"External window %@\n Do something with External Display\n", window] ];
		
		//NSString *movestr = @"http://bgmp-w.bitgravity.com/cdn-live-s1/_definst_/twit/live/high/playlist.m3u8";
		NSString *movestr = @"http://www.nasa.gov/multimedia/nasatv/NTV-Public-IPS.m3u8";
		
		NSURL *theMovieURL = [NSURL URLWithString:movestr];
		
		if (theMovieURL)
		{
			if ([theMovieURL scheme])	// sanity check on the URL
			{
				// Play the movie with the specified URL. 
                [movieController playMovieStream:theMovieURL];
				toggleMoviePlaybackSwitch.on = TRUE;
			}
		}
	}
	

}

-(IBAction)ChangeMovieState
{
	if (toggleMoviePlaybackSwitch.on) { 
		[movieController resumeMovieStream];
	}else { 
		[movieController pauseMovieStream];
	}

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	movieController = [MyMovieViewController alloc];
	
	TTMonitorOut *TVOut = [[TTMonitorOut alloc] initWithView:movieController.view];
	TVOut.delegate = self;
	[TVOut displayExternalView];
	NSLog(@"External %d", [TVOut externalMonitor]);

	
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

@end
