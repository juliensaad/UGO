//
//  UViewController.h
//  U:GO
//
//  Created by Julien Saad on 11/15/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>{
	
	NSArray *venueImages;
}

@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIView *middleBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomContentView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

- (IBAction)infoClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)menuClick:(id)sender;

@end
