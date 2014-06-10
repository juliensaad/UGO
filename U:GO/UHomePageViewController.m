//
//  UHomePageViewController.m
//  U:GO
//
//  Created by Julien Saad on 11/21/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import "UHomePageViewController.h"
#import "UViewController.h"
#import "WSingleton.h"
#import "URequests.h"
@interface UHomePageViewController ()

@property NSMutableArray *data;
@end

@implementation UHomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillLayoutSubviews{

	//	[self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
   
}

-(void)viewDidLayoutSubviews{
    if(!ISIPHONE5){
        _topBar.hidden = YES;
        [_content setFrame:CGRectMake(0, 0, _content.frame.size.width, _content.frame.size.height)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _v1.text = lVISIT;
    _v2.text = lVISIT;
    _v3.text = lVISIT;
    _v4.text = lVISIT;
    
    _selectGuideLabel.text = [lSELECTGUIDE uppercaseString];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
 
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:NO];
    // Destack views
	NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
	[allViewControllers removeObjectIdenticalTo: self.navigationController.parentViewController];
	self.navigationController.viewControllers = allViewControllers;
	//	[self.navigationController popViewControllerAnimated:NO];
	
	// Do any additional setup after loading the view, typically from a nib.
	[self.view setBackgroundColor:UIColorFromRGB(UGOGRAY)];
    @try {
	_data = [[WSingleton sharedManager]webContent];
	
	NSArray *personaLabels = [[NSArray alloc] initWithObjects:_persona1,_persona2,_persona3,_persona4, nil];
	
	for(int i = 0;i<personaLabels.count;i++){

        if(!ISFRENCH){
		[[personaLabels objectAtIndex:i] setText:[[[_data objectAtIndex:i] name] uppercaseString]];
        }else{
           [[personaLabels objectAtIndex:i] setText:[[[_data objectAtIndex:i] personaNameFr] uppercaseString]];
        }
		[[personaLabels objectAtIndex:i] setFont:FONT_EXTRA_SMALL];
	}
	//[_selectGuideLabel setFont:FONT_BOLD_SMALL];

        [URequests getImageWithURL:[[_data objectAtIndex:0] personaId] andImageView:_im1];
        [URequests getImageWithURL:[[_data objectAtIndex:1] personaId] andImageView:_im2];
        [URequests getImageWithURL:[[_data objectAtIndex:2] personaId] andImageView:_im3];
        [URequests getImageWithURL:[[_data objectAtIndex:3] personaId] andImageView:_im4];
        
        [_im1 setType:[[[_data objectAtIndex:0] venue] type]];
        [_im2 setType:[[[_data objectAtIndex:1] venue] type]];
        [_im3 setType:[[[_data objectAtIndex:2] venue] type]];
        [_im4 setType:[[[_data objectAtIndex:3] venue] type]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
	
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sidebarClick:(id)sender {
	 [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	[[_data objectAtIndex:0] setImg:_im1.image];
	[[_data objectAtIndex:1] setImg:_im2.image];
	[[_data objectAtIndex:2] setImg:_im3.image];
	[[_data objectAtIndex:3] setImg:_im4.image];

	if([segue.identifier isEqualToString:@"b1"]){
		[[WSingleton sharedManager] setCurrentVenue:0];
	}else if([segue.identifier isEqualToString:@"b2"]){
		[[WSingleton sharedManager] setCurrentVenue:1];
	}else if([segue.identifier isEqualToString:@"b3"]){
		[[WSingleton sharedManager] setCurrentVenue:2];
	}else if([segue.identifier isEqualToString:@"b4"]){
		[[WSingleton sharedManager] setCurrentVenue:3];
	}
}

-(void)viewDidDisappear:(BOOL)animated{
    [[_data objectAtIndex:0] setImg:_im1.image];
	[[_data objectAtIndex:1] setImg:_im2.image];
	[[_data objectAtIndex:2] setImg:_im3.image];
	[[_data objectAtIndex:3] setImg:_im4.image];
}

@end
