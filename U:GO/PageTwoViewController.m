//
//  PageTwoViewController.m
//  U:GO
//
//  Created by Julien Saad on 2014-06-03.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "PageTwoViewController.h"

@interface PageTwoViewController ()

@end

@implementation PageTwoViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"OMG");
    
    self.view.backgroundColor = [UIColor clearColor];
    [UIView beginAnimations:nil context:nil];
    //[UIView setAnimationDuration:10.0];
    
    // _welbomeLabel.alpha = 0.0;
    [UIView commitAnimations];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
