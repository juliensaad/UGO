//
//  UKingViewController.m
//  U:GO
//
//  Created by Julien Saad on 1/2/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UKingViewController.h"

@interface UKingViewController ()

@end

@implementation UKingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)awakeFromNib{
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toplogo.png"]];
}

- (void)viewDidLoad
{
	
    [super viewDidLoad];
	
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	[self.navigationController.navigationBar setTranslucent:NO];
    // self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toplogo.png"]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
