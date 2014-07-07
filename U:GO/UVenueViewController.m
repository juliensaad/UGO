//
//  UVenueViewController.m
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UVenueViewController.h"
#import "WSingleton.h"
#import "Persona.h"
#import "URequests.h"

#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"

#import "PriceTag.h"
@interface UVenueViewController ()

@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;

@property (nonatomic, strong) Persona* content;

@property (nonatomic, strong) PriceTag* priceTag;

@end

@implementation UVenueViewController
IDMPhotoBrowser *browser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define kImageURL @"http://thirdbridge.net/ugo/"

-(void)viewDidLayoutSubviews{
    // [self.venueView.bottomContentView setFrame:CGRectMake(self.venueView.bottomContentView.frame.origin.x, self.venueView.bottomContentView.frame.origin.x-70, self.venueView.bottomContentView.frame.size.width, self.venueView.bottomContentView.frame.size.height)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 4;
    
    self.imageCache = [[NSCache alloc] init];
 
    
	// Do any additional setup after loading the view.
	NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"Venue" owner:self options:nil];
	_venueView = [subviewArray objectAtIndex:0];
	[self.view addSubview:_venueView];
	
    
    [self.venueView.venueDesc setSelectable:NO];
    [self.venueView.venueDesc setEditable:NO];
    
	// Do any additional setup after loading the view, typically from a nib.
	[self.navigationController.navigationBar setTranslucent:NO];
	
	
	[self.view setBackgroundColor:UIColorFromRGB(UGOWHITE)];
	[self.venueView.topBarView setBackgroundColor:UIColorFromRGB(UGOTURQUOISE)];
	[self.venueView.middleBarView setBackgroundColor:UIColorFromRGB(UGOGRAY)];
	[self.venueView.bottomContentView setBackgroundColor:UIColorFromRGB(UGOWHITE)];
	
	//self.venueView.collectionview.delegate = self;
	//self.venueView.collectionview.dataSource = self;
	
	[_pageControl setCurrentPage:0];
    
    
    if(_comingFromFav){
        _content = [[[WSingleton sharedManager]favourites] objectAtIndex:[[WSingleton sharedManager] currentVenue]];
    }else{
        _content = [[[WSingleton sharedManager]webContent] objectAtIndex:[[WSingleton sharedManager] currentVenue]];
    }
    int nbImages = (int)_content.venue.imgUrls.count;
    [_pageControl setNumberOfPages:nbImages];
    
	[self.view bringSubviewToFront:_pageControl];
    _cv.delegate = self;
    _cv.dataSource = self;
    
    [_cv addSubview:_pageControl];
	[_venueView.weeksPickView addSubview:_cv];
	[_venueView.weeksPickView sendSubviewToBack:_cv];
    [_venueView.weeksPickView addSubview:_pageControl];
    [_venueView.favButton addTarget:self action:@selector(addFavourite) forControlEvents:UIControlEventTouchUpInside];
    
    [_venueView.heartButton addTarget:self action:@selector(addFavourite) forControlEvents:UIControlEventTouchUpInside];
    
	
	[self showContent];
    
    // URLs array
    NSMutableArray *photosURL = [[NSMutableArray alloc] init];
    
    for(NSString* u in _content.venue.imgUrls){
        [photosURL addObject:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageURL, u]]];
    }
    
    // Create an array to store IDMPhoto objects
    NSMutableArray *photos = [NSMutableArray new];
    
    for (NSURL *url in photosURL) {
        IDMPhoto *photo = [IDMPhoto photoWithURL:url];
        [photos addObject:photo];
    }
    
    browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayDoneButton = NO;
    browser.displayActionButton = NO;

	
    [self.venueView.priceButton addTarget:self action:@selector(popupPrice:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Add the price tag
    //  NSArray *subviewArray2 = [[NSBundle mainBundle] loadNibNamed:@"PriceTag" owner:self options:nil];
	//_priceTag = [subviewArray2 objectAtIndex:0];
    

    
    [self.venueView.priceBox setAlpha:0.0];
    [self.venueView bringSubviewToFront:self.venueView.priceBox];

    //    _priceTag.alpha = 0.0;
    
}
-(void)popupPrice:(id)sender{
    // Do any additional setup after loading the view.
                             _pageControl.alpha = 0.0;
    [UIView animateWithDuration:0.4f
                     animations:^{
                         self.venueView.priceBox.alpha = 1.0;

                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [UIView animateWithDuration:0.5f
                                                   delay:2.4f options:kNilOptions animations:^{
                                                       self.venueView.priceBox.alpha = 0.0;
                                                       _pageControl.alpha = 1.0;
                                                   }                                        completion:^(BOOL finished) {
                                                  if (finished) {
                                                      
                                                  }
                                              }];

                         }
                     }];
    
	
}

-(void)showContent{
    
    NSString* pdesc = ISFRENCH?[_content personaDescriptionFr]:[_content personaDescription];
    
	
	[self.venueView.personaDesc setText:pdesc];
	[self.venueView.personaName setText:ISFRENCH?[_content personaNameFr]:[_content name]];
	
	[self.venueView.venueName setText:[[_content venue] name]];
    
    NSString* desc = ISFRENCH?[[_content venue] descriptionFr]:[[_content venue] descriptionEn];
	[self.venueView.venueDesc setText:desc];
    [self.venueView.venueDesc setFont:FONT_BOLD_EXTRA_SMALL];
    [self.venueView.venueDesc setTextColor:UIColorFromRGB(0x666666)];
    
    self.venueView.bestTime.text = ISFRENCH?@"Temps idéal:":@"Best time:";
    self.venueView.bestTime.adjustsFontSizeToFitWidth = YES;
	
	[self.venueView.personaFace setImage:[_content img]];
    self.venueView.persona = _content;
    
    [self.venueView.backgroundType setImage:[UIImage imageNamed:[NSString stringWithFormat:ISFRENCH?@"type-fr%d.png":@"type%d.png",_content.venue.type]]];
    [self.venueView.backgroundType setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.venueView.callButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *pageColor;
    switch (_content.venue.type) {
        case 0:
            pageColor = UIColorFromRGB(UGO_TYPE1);
            break;
        case 1:
            pageColor = UIColorFromRGB(UGO_TYPE2);
            break;
        case 2:
            pageColor = UIColorFromRGB(UGO_TYPE3);
            break;
        case 3:
            pageColor = UIColorFromRGB(UGO_TYPE4);
            break;
        case 4:
            pageColor = UIColorFromRGB(UGO_TYPE5);
            break;
            
        default:
            break;
    }
    
    self.venueView.personaName.textColor = pageColor;
    self.venueView.wpButton.backgroundColor = pageColor;
    self.venueView.bestTime.textColor = pageColor;
    self.venueView.priceLabel.textColor = pageColor;
    self.pageControl.currentPageIndicatorTintColor = pageColor;
    self.venueView.titleBar.backgroundColor = pageColor;
    self.pageControl.userInteractionEnabled = NO;
    
    
    [self.venueView.fbButton addTarget:self action:@selector(facebookPage) forControlEvents:UIControlEventTouchUpInside];
    
    NSString* price;
    NSString* tagPrice;
    
    switch ([[_content venue] price]) {
        case 0:
            tagPrice = @"$: 0-10$";
            price = @"$";
            break;
        case 1:
            tagPrice = @"$$: 10-20$";
            price = @"$$";
            break;
        case 2:
            tagPrice = @"$$$: 20-30$";
            price = @"$$$";
            break;
        case 3:
            tagPrice = @"$$$$: 30+";
            price = @"$$$$";
            break;
            
        default:
            break;
    }
    [self.venueView.priceLabel setText:price];

    
    [self.venueView.timeLabel setText:[[_content venue] bestTime]];
    [self.venueView.iconography setBackgroundColor:[[_content venue] color]];
    UIImageView* icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",_content.venue.icono]]];
    
    [icon setFrame:CGRectMake(5, 5, 20, 20)];
    [self.venueView.iconography addSubview:icon];
    
    
    
    
    
}


-(void)facebookPage{
    NSURL *url = [NSURL URLWithString:_content.venue.fbUrl];
    [[UIApplication sharedApplication] openURL:url];
    
}
-(void)call{
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[_content venue] phoneNumber]]]];
    } else {
        UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notPermitted show];
        
    }
}
#define PERSONPOSY 372
-(void)viewWillDisappear:(BOOL)animated{
    
    //[self.venueView.weeksPickView setFrame:CGRectMake(0, self.venueView.weeksPickView.frame.origin.y-PERSONPOSY, yScreenWidth, yScreenHeight)];
    //[self.venueView.personView setFrame:CGRectMake(0, -PERSONPOSY, yScreenWidth, yScreenHeight)];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        self.screenName = @"Venue Screen - iOS";
    
    [self.venueView setIsWeeksPickUp:NO];
    //   [self.venueView.weeksPickView setFrame:CGRectMake(0, self.venueView.weeksPickView.frame.origin.y-PERSONPOSY, yScreenWidth, yScreenHeight)];
    //  [self.venueView.personView setFrame:CGRectMake(0, -PERSONPOSY, yScreenWidth, yScreenHeight)];
    
}


-(void)addFavourite{
    // Check if user is logged in first
   
    [URequests addFavourite:_content.venue.dBID];
}

#pragma mark UICollectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [browser getPics].count;
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[venueImages objectAtIndex:indexPath.row]];
    
    

    if(_content.venue.imgUrls.count>=indexPath.row && _content.venue.imgUrls.count >0){
        // recipeImageView.image = [[[browser getPics] objectAtIndex:indexPath.row] underlyingImage];
    }
        //  [UVenueViewController getImageWithURL:[content.venue.imgUrls objectAtIndex:indexPath.row] andImageView:recipeImageView];
    NSString* u =_content.venue.imgUrls[indexPath.row];
    NSString *imageUrlString = [NSString stringWithFormat:@"%@%@",kImageURL, u];
    UIImage *imageFromCache = [self.imageCache objectForKey:imageUrlString];
    
    if (imageFromCache) {
        recipeImageView.image = imageFromCache;
    }
    else
    {
        //   recipeImageView.image = [UIImage imageNamed:@"Placeholder"];
        
        [self.imageOperationQueue addOperationWithBlock:^{
            NSURL *imageurl = [NSURL URLWithString:imageUrlString];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
            
            if (img != nil) {
                
                // update cache
                [self.imageCache setObject:img forKey:imageUrlString];
                
                // now update UI in main queue
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // see if the cell is still visible ... it's possible the user has scrolled the cell so it's no longer visible, but the cell has been reused for another indexPath
                       UICollectionViewCell *updateCell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                    
                    // if so, update the image
                    if (updateCell) {
                        UIImageView *recipeImageView = (UIImageView *)[updateCell viewWithTag:100];
                        //[updateCell.imageCellTL setFrame:...]; // I don't know what you want to set this to, but make sure to set it appropriately for your cell; usually I don't mess with the frame.
                        [recipeImageView setImage:img];
                    }
                }];
            }
        }];
    }
    
    recipeImageView.contentMode = UIViewContentModeScaleAspectFill;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self presentViewController:browser animated:NO completion:nil];
}



+(void)getImageWithURL:(NSString*)url andImageView:(UIImageView*)im{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kImageURL, url]]];
	
	NSLog(@"%@", request.URL.path);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
								   if(im!=nil){
									   UIImage *image = [[UIImage alloc] initWithData:data];
									   [im setImage:image];
                                       
								   }
							   } else{
								   // Do nothing
							   }
                           }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.cv.frame.size.width;
    self.pageControl.currentPage = self.cv.contentOffset.x / pageWidth;
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
