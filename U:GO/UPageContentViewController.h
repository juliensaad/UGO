//
//  UPageContentViewController.h
//  U:GO
//
//  Created by Julien Saad on 2014-06-01.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@property BOOL goAnimation;

@end
