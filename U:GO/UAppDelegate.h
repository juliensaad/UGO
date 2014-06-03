//
//  UAppDelegate.h
//  U:GO
//
//  Created by Julien Saad on 11/15/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNavigationViewController.h"
#import "UViewController.h"
#import "USideMenuViewController.h"
#import "USplashViewController.h"


@interface UAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) USplashViewController *mainController;

@property (nonatomic, strong) USideMenuViewController* sideController;

@property (nonatomic, strong) TWTSideMenuViewController* sideMenuViewController;
@end
