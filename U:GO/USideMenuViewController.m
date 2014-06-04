//
//  USideMenuViewController.m
//  U:GO
//
//  Created by Julien Saad on 11/21/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import "USideMenuViewController.h"
#import "UHomePageViewController.h"
#import "UFavouritesViewController.h"
#import "UViewController.h"
#import "UAboutUsViewController.h"
#import "WSingleton.h"
#import "URequests.h"

@interface USideMenuViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation USideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews{
    if(!ISIPHONE5){
        [_sideView setFrame:CGRectMake(_sideView.frame.origin.x, _sideView.frame.origin.y-40, _sideView.frame.size.width, _sideView.frame.size.height)];
        [_fbView setFrame:CGRectMake(0, 380, _fbView.frame.size.width, _fbView.frame.size.height)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupBackground];
    
    _loginView.delegate = self;

    
    [_l1 setTitle:lPICKS forState:UIControlStateNormal];
    [_l2 setTitle:lSAIL forState:UIControlStateNormal];
    [_l3 setTitle:lFAVS forState:UIControlStateNormal];
    [_l4 setTitle:lABOUT forState:UIControlStateNormal];
    
    [_l1 addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_l1 setEnabled:YES];
    _unlockLabel.text = lUNLOCKALL;
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    NSLog(@"%@",user.id);
    [[[WSingleton sharedManager] defaults] setObject:user.id forKey:@"userid"];
    
    [[[WSingleton sharedManager] defaults] setObject:user.name forKey:@"username"];
    
    [[[WSingleton sharedManager] defaults] setObject:@"YES" forKey:@"isloggedin"];
    
    NSDictionary *params = @{@"name": [user objectForKey:@"name"],
                             @"first_name":[user objectForKey:@"first_name"],
                             @"last_name":[user objectForKey:@"last_name"],
                             @"gender":[user objectForKey:@"gender"],
                             @"locale":[user objectForKey:@"locale"],
                             @"id": user.id};
    
    [URequests createUser:params];
    
    _unlockLabel.text= [NSString stringWithFormat:@"Welcome %@!", user.name];
    //    user.name;
}

-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    _unlockLabel.text = lUNLOCKALL;
    
    
    [[[WSingleton sharedManager] defaults]setObject:@"NO" forKey:@"isloggedin"];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", error);
}

-(void)setupBackground{
	
	self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"galaxy"]];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
    NSDictionary *viewDictionary = @{ @"imageView" : self.backgroundImageView };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]" options:0 metrics:nil views:viewDictionary]];
	
	[self.view sendSubviewToBack:self.backgroundImageView];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    return wasHandled;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonPressed:(id)sender {
	
	[self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    NSLog(@"close");
}

- (IBAction)sailClick:(id)sender {
	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UViewController* nextView = (UViewController *)[sb instantiateViewControllerWithIdentifier:@"HomePage"];
	UFavouritesViewController* fav = (UFavouritesViewController *)[sb instantiateViewControllerWithIdentifier:@"Sail"];
	
	UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:nextView];
    
	[controller pushViewController:fav animated:YES];
	[self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];

}


- (IBAction)favClick:(id)sender {
	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UViewController* nextView = (UViewController *)[sb instantiateViewControllerWithIdentifier:@"HomePage"];
	UFavouritesViewController* fav = (UFavouritesViewController *)[sb instantiateViewControllerWithIdentifier:@"Favourites"];
	
	UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:nextView];
    
	[controller pushViewController:fav animated:YES];
	[self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];

}

- (IBAction)aboutClick:(id)sender {
	UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UViewController* nextView = (UViewController *)[sb instantiateViewControllerWithIdentifier:@"HomePage"];
	UAboutUsViewController* fav = (UAboutUsViewController *)[sb instantiateViewControllerWithIdentifier:@"About"];
	
	UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:nextView];
    
	[controller pushViewController:fav animated:YES];
	[self.sideMenuViewController setMainViewController:controller animated:YES closeMenu:YES];

}

+(void)goToVC:(id)vc{
	
}
@end
