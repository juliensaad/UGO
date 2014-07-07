//
//  UAppDelegate.m
//  U:GO
//
//  Created by Julien Saad on 11/15/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import "UAppDelegate.h"
#import "URequests.h"
#import "WSingleton.h"
#import "GAI.h"
#import "config.h"

@implementation UAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-52250247-2"];
    
    
	[FBLoginView class];
	[self downloadAppContent];
    
   
    
       
    // ask to send notifications
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    [self scheduleNotifications];
    
	
    return YES;
}

-(void)scheduleNotifications{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSCalendar *gregCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponent = [gregCalendar components:NSYearCalendarUnit  | NSWeekCalendarUnit fromDate:[NSDate date]];
    
    [dateComponent setWeekday:2]; // For Monday
    [dateComponent setHour:19];
    [dateComponent setMinute:30];
    
    
    NSDate *fireDate = [gregCalendar dateFromComponents:dateComponent];
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setAlertBody:ISFRENCH?@"Blabla":@"This week's venues are out! Go check them out now!"];
    [notification setFireDate:fireDate];
    notification.repeatInterval = NSWeekCalendarUnit;
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)downloadAppContent{
	[self setupAppearence];

}

-(void)setupAppearence{
	/*CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
	NSString *imageFile = (screenHeight == 568.0f) ? @"LaunchImage@2x.png" : @"LaunchImage@2x.png";
	UIImageView *splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageFile]];
	
	[self.window.rootViewController.view addSubview:splash];
	
	[UIView animateWithDuration:1.0
					 animations:^{
						 splash.alpha = 0;
					 }
					 completion:^(BOOL finished) {
						 [splash removeFromSuperview];
					 }
	 ];
	*/
	//display the main window
	[self.window makeKeyAndVisible];
    
	[[UINavigationBar appearance] setBarTintColor:TBAR_COLOR];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
   

	
	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	self.mainController = (USplashViewController *)[sb instantiateViewControllerWithIdentifier:@"Splash"];
	self.sideController = [[USideMenuViewController alloc] initWithNibName:@"USideMenuViewController" bundle:nil];
	
	// create a new side menu
	self.sideMenuViewController = [[TWTSideMenuViewController alloc] initWithMenuViewController:self.sideController mainViewController:[[UINavigationController alloc] initWithRootViewController:self.mainController]];
	[self.sideMenuViewController.navigationController setNavigationBarHidden:NO];
	// specify the shadow color to use behind the main view controller when it is scaled down.
	self.sideMenuViewController.shadowColor = UIColorFromRGB(UGOGRAY);
	
	// specify a UIOffset to offset the open position of the menu
	self.sideMenuViewController.edgeOffset = UIOffsetMake(30.0f, 0.0f);
	
	// specify a scale to zoom the interface — the scale is 0.0 (scaled to 0% of it's size) to 1.0 (not scaled at all). The example here specifies that it zooms so that the main view is 56.34% of it's size in open mode.
	self.sideMenuViewController.zoomScale = 0.4034f;
	
	// set the side menu controller as the root view controller
	self.window.rootViewController = self.sideMenuViewController;
	
	[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 600.f) forBarMetrics:UIBarMetricsDefault];
	

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [URequests getEventsWithSuccessFunction:nil andSender:self];
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
