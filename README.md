TTMonitor Out
=================

Push a view to the External Display of the iPhone/iPad.  This is based on multiple samples found but I didn't find as flexable. 
Currently this will push the view to the best available display.  Works well with Video Mirror with AppleTV as well.

Usage
-----

The lib is setup to be rather simple.  Initilize the External View Object, register for delegates and Tell it to start monitoring for Extrnal Displays.  

Sample of usage:
    //Create a Movie View Controller (from Apple Sample Code)
	movieController = [MyMovieViewController alloc];
	
	//Create the External Display View with the view of the movieController
	TTMonitorOut *TVOut = [[TTMonitorOut alloc] initWithView:movieController.view];
	//Register for the delegates
	TVOut.delegate = self;
	//Start the Extrnal View
	[TVOut displayExternalView];


Authors
-------

**Kevin A. Hoogheem**

+ http://twitter.com/khoogheem
+ http://github.com/khoogheem

Copyright and license
---------------------

Copyright 2011 Kevin A. Hoogheem

Versioning
----------
