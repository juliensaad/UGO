//
//  UVenueViewController.h
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UKingViewController.h"
#import "UVenueView.h"

@interface UVenueViewController : UKingViewController<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>{
	NSMutableArray *venueImages;
    NSMutableDictionary *imgDic;
}

@property (nonatomic, strong) UVenueView *venueView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UICollectionView *cv;

@property BOOL comingFromFav;
@end
