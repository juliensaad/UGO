//
//  UViewController.m
//  U:GO
//
//  Created by Julien Saad on 11/15/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import "UViewController.h"

@interface UViewController ()

@end

@implementation UViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	[self.navigationController.navigationBar setTranslucent:NO];
	
	
	[self.view setBackgroundColor:UIColorFromRGB(UGOWHITE)];
	[self.topBarView setBackgroundColor:UIColorFromRGB(UGOTURQUOISE)];
	[self.middleBarView setBackgroundColor:UIColorFromRGB(UGOGRAY)];
	//[self.bottomContentView setBackgroundColor:UIColorFromRGB(UGOWHITE)];
	
	 venueImages = [NSArray arrayWithObjects:@"13-image.png", @"13-image.png",@"13-image.png", @"13-image.png", nil];
	[_pageControl setCurrentPage:0];
	[_pageControl setNumberOfPages:venueImages.count];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    [_pageControl setHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark UICollectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return venueImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[venueImages objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionview.frame.size.width;
    self.pageControl.currentPage = self.collectionview.contentOffset.x / pageWidth;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoClicked:(UIButton*)sender{
	//[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menuClick:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
	
	//[self.sideMenuViewController openMenuAnimated:YES completion:nil];
}
@end
