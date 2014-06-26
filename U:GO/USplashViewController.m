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

#import "PageTwoViewController.h"

@interface USplashViewController ()
@property UIImageView* phone;

@property UIImageView* dots;
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
#define U_X_FINAL 56.5
#define O_X_FINAL 197

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    // Init xib files
    //dispatch_async(dispatch_get_main_queue(), ^{
    
        //});
    

    
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
                             
                             // Preload xib file
                              [[NSBundle mainBundle] loadNibNamed:@"Venue" owner:self options:nil];
                             if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"]){
                                 [URequests getEventsWithSuccessFunction:@selector(venueTime) andSender:self];
                                 
                             }else{
                                 
                                 [URequests getEventsWithSuccessFunction:@selector(nothing) andSender:self];
                                  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
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

-(void)nothing{
    
}

-(void)venueTime{
    	[self performSegueWithIdentifier:@"venue" sender:self];
}

-(void)transition{

    // Create page view controller
     self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
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
            // scroll.bounces = NO;
            scroll.scrollEnabled = YES;
            scroll.pagingEnabled = YES;
            
        }
    }
    
    self.pageViewController.view.backgroundColor = [UIColor clearColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    
    self.pageViewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.66];
    
    [UIView commitAnimations];
    
   
    [self performSelector:@selector(changePage:) withObject:UIPageViewControllerNavigationDirectionForward afterDelay:2.0];
   
    
    _dots = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dots1.png"]];
    
    _dots.frame = CGRectMake(30, 450, _dots.frame.size.width, _dots.frame.size.height);
    [self.pageViewController.view addSubview:_dots];
    
   

}

- (void)changePage:(UIPageViewControllerNavigationDirection)direction {
    NSUInteger pageIndex = ((UPageContentViewController *) [_pageViewController.viewControllers objectAtIndex:0]).pageIndex;
    
    if (direction == UIPageViewControllerNavigationDirectionForward) {
        pageIndex++;
    }
    else {
        pageIndex--;
    }
    
    UIViewController *viewController = [self viewControllerAtIndex:pageIndex];
    
    
    if (viewController == nil) {
        return;
    }
    
    [_pageViewController setViewControllers:@[viewController]
                                  direction:direction
                                   animated:YES
                                 completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)startWalkthrough:(id)sender {
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    NSLog(@"%lu index", (unsigned long)index);
    if(index ==0){
    // Create a new view controller and pass suitable data.
        UPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContent"];
        pageContentViewController.imageFile = self.pageImages[index];
        pageContentViewController.titleText = self.pageTitles[index];
        pageContentViewController.pageIndex = index;
        
            
        
        return pageContentViewController;
    }else{
        
        PageTwoViewController* page2 = [self.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"Page%lu",(unsigned long)index]];
        
        
        if(ISFRENCH){
            NSLog(@"%@%d", t1, index);
            
            UILabel* title = (UILabel*)[page2.view viewWithTag:1];
            page2.t2Label.adjustsFontSizeToFitWidth = YES;
            page2.t1Label.adjustsFontSizeToFitWidth = YES;
            switch (index) {
                case 1:
                    title.text = t1;
                    page2.t1Label.text = l0;
                    page2.t2Label.text = l01;
                    break;
                case 2:
                    title.text = t2;
                    page2.t1Label.text = l1;
                    page2.t2Label.text = l12;
                    break;
                case 3:
                    title.text = t3;
                    page2.t1Label.text = l2;
                    page2.t2Label.text = l22;
                    break;
                case 4:
                    title.text = t4;
                    page2.t1Label.text = l3;
                    page2.t2Label.text = l32;
                    [page2.goButton setTitle:@"Débuter" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }
        BOOL found = NO;
        for(UIView *v in _pageViewController.view.subviews){
            if(v.tag==123){
                found = YES;
            }
        }
        if(!found){
            _phone = [[UIImageView alloc] initWithFrame:CGRectMake(72, 600, 177, 205)];
            _phone.tag = 123;
          
              [_pageViewController.view addSubview:_phone];
            
            

            [UIView transitionWithView:_phone
                              duration:0.6f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                _phone.image = [UIImage imageNamed:[NSString stringWithFormat:@"phone1.png"]];
                            } completion:nil];
            
            [UIView transitionWithView:_dots
                              duration:0.6f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                _dots.image = [UIImage imageNamed:@"dots2.png"];
                                
                                
                            } completion:nil];
           
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            [UIView setAnimationDelay:0.4];
            CGRect fr = _phone.frame;
            fr.origin.y = 363;
            _phone.frame = fr;
            [UIView commitAnimations];
            
            if(!ISIPHONE5){
                _dots.hidden = YES;
                _phone.hidden = YES;
            }
        }
        
        page2.pageIndex = index;
        return page2;
    }
    
    return nil;
}

#pragma mark - Page View Controller Data Source
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *vc = [pageViewController.viewControllers lastObject];
    
    if([((UPageContentViewController*) vc)pageIndex]==0){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelay:0.0];
        CGRect fr = _phone.frame;
        fr.origin.y = 600;
        _phone.frame = fr;
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelay:0.0];
        CGRect fr = _phone.frame;
        fr.origin.y = 363;
        _phone.frame = fr;
        
        
        [UIView transitionWithView:_phone
                          duration:0.6f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            _phone.image = [UIImage imageNamed:[NSString stringWithFormat:@"phone%lu.png",(unsigned long)[((UPageContentViewController*) vc)pageIndex]
                                                                ]];
                           
                        } completion:nil];
        
        [UIView transitionWithView:_dots
                          duration:0.6f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            _dots.image = [UIImage imageNamed:[NSString stringWithFormat:@"dots%lu.png",(unsigned long)[((UPageContentViewController*) vc)pageIndex]+1
                                                               ]];

                            
                        } completion:nil];
        
        
        [UIView commitAnimations];
        
    }
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
    if (index == 5) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
