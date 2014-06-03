//
//  USuggestionViewController.m
//  U:GO
//
//  Created by Julien Saad on 11/21/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import "USuggestionViewController.h"

@interface USuggestionViewController ()

@end

@implementation USuggestionViewController

CGRect arrowFrame;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.isWeeksPickUp = NO;
	arrowFrame = _smallArrow.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#define PERSONPOSY 381
- (IBAction)weeksPickClick:(id)sender {
	
	if(!self.isWeeksPickUp){
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.7];
	
		[self.weeksPickView setFrame:CGRectMake(0, 0, yScreenWidth, yScreenHeight)];
		[self.personView setFrame:CGRectMake(0, -PERSONPOSY, yScreenWidth, yScreenHeight)];
	
		
		CGRect newFrame = arrowFrame;
		newFrame.origin.y +=30;
		//_smallArrow.frame = newFrame;
		_smallArrow.transform = CGAffineTransformMakeRotation(M_PI);
		
		
		[UIView commitAnimations];
		
		self.isWeeksPickUp = YES;
		
		
	}else{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:0.7];
		
		[self.weeksPickView setFrame:CGRectMake(0, PERSONPOSY, yScreenWidth, yScreenHeight)];
		[self.personView setFrame:CGRectMake(0, 0, yScreenWidth, yScreenHeight)];
		//_smallArrow.frame = arrowFrame;
		_smallArrow.transform = CGAffineTransformMakeRotation(0);

		[UIView commitAnimations];
		self.isWeeksPickUp = NO;

	}
}

-(void)viewWillDisappear:(BOOL)animated{
	
	self.isWeeksPickUp = NO;
	arrowFrame = _smallArrow.frame;
	
}
@end
