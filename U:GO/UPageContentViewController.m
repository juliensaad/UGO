//
//  UPageContentViewController.m
//  U:GO
//
//  Created by Julien Saad on 2014-06-01.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UPageContentViewController.h"

@interface UPageContentViewController ()

@end

@implementation UPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //_goAnimation = YES;
    // if(self.goAnimation){
    if(ISFRENCH){
        _welcomeLabel.text = @"Bienvenue";
    }
    
        self.view.backgroundColor = [UIColor clearColor];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.3];
        
    // self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.66];
        _welcomeLabel.alpha = 1.0;
        [UIView commitAnimations];
    //}
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
