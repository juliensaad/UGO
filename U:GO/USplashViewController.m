//
//  USplashViewController.m
//  U:GO
//
//  Created by Julien Saad on 1/27/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "USplashViewController.h"
#import "WSingleton.h"
#import "URequests.h"

@interface USplashViewController ()

@end

@implementation USplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define G_Y_FINAL 236
#define U_X_FINAL 58
#define O_X_FINAL 197

- (void)viewDidLoad
{
    [super viewDidLoad];
	

	CGRect gFrame = [_gLetter frame];
	gFrame.origin.y = -80;
	[_gLetter setFrame:gFrame];
	
	
	[self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view.
	
	_shadow.alpha = 0.0;
	/*_b1.alpha = 0.0;
	_b2.alpha = 0.0;
	_b3.alpha = 0.0;
	*/

	[UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
						 
				
						 CGRect gFrame = [_gLetter frame];
						
						 
						 gFrame.origin.y = G_Y_FINAL;
						 
						 [_gLetter setFrame:gFrame];
		
						 _shadow.alpha = 0.8;

                         
                     }
                     completion:^(BOOL finished){
						 
						 [UIView animateWithDuration:1.0 animations:^{
							 CGRect uFrame = [_uLetter frame];
							 uFrame.origin.x = U_X_FINAL;
							 CGRect oFrame = [_oLetter frame];
							 oFrame.origin.x = O_X_FINAL;
							 [_uLetter setFrame:uFrame];
							 [_oLetter setFrame:oFrame];
							 
							 _uLetter.alpha = 1.0;
							 _oLetter.alpha = 1.0;
							
							 _b1.alpha = 1.0;
							 _b2.alpha = 1.0;
							 _b3.alpha = 1.0;
							 
							 if(![[WSingleton sharedManager] isLoggedIn]){
								 CGRect frame = _btnView.frame;
								 frame.origin.y -= 180;
								 [_btnView setFrame:frame];
								 
								 CGRect txtFrame = _splashText.frame;
								 txtFrame.origin.y -= 180;
								 [_splashText setFrame:txtFrame];
								 
								  _splashText.alpha = 0.0;
							 }
							 
							
							 

						 } completion:^(BOOL finished){
                             
                             if(YES){
							 [URequests getEventsWithSuccessFunction:@selector(venueTime) andSender:self];
                                 
                             }else{
                                 [self transition];
                                 _uLetter.hidden = YES;
                                 _oLetter.hidden = YES;
                                 _gLetter.hidden = YES;
                                 _shadow.hidden = YES;
                             }
						 }];
												 						 
					} ];
	//

		
}

-(void)venueTime{
    	[self performSegueWithIdentifier:@"venue" sender:self];
}

-(void)transition{
    //	[self performSegueWithIdentifier:@"venue" sender:self];
    //	[self performSegueWithIdentifier:@"slider" sender:self];
    
    // Create the data model
    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
    self.pageViewController.dataSource = self;
    
    UPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    _pageViewController.delegate = self;

    [self startWalkthrough:self];
    
    // Remove bounce
    for (UIView *view in self.pageViewController.view.subviews ) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView *)view;
            scroll.bounces = NO;
            scroll.scrollEnabled = YES;
            scroll.pagingEnabled = YES;
            
        }
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)startWalkthrough:(id)sender {
    UPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (UPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    UPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContent"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    NSLog(@"switch");
   /* [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    

    
    [UIView commitAnimations];*/
    
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    NSLog(@"coucou");
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((UPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((UPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
