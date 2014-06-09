//
//  UAboutUsViewController.m
//  U:GO
//
//  Created by Julien Saad on 1/5/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UAboutUsViewController.h"

@interface UAboutUsViewController ()

@end

@implementation UAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)emailClick:(id)sender {
    NSLog(@"send the email");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:info@ugoapp.com?subject=Hello%20UGO!&body="]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
