//
//  UFavouritesViewController.m
//  U:GO
//
//  Created by Julien Saad on 1/5/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UFavouritesViewController.h"
#import "URequests.h"
#import "WSingleton.h"
#import "UVenueViewController.h"

@interface UFavouritesViewController ()
@property NSMutableArray* data;
@property NSMutableArray* favs;
@end

@implementation UFavouritesViewController

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [URequests getFavourites:@selector(loadContent:) :self];
    _favs = [[NSMutableArray alloc]init];
}

-(void)loadContent:(NSMutableArray*)favs{
    _favs = favs;
    
    _data = [[WSingleton sharedManager] favourites];
    
    for(int i = 0;i<_data.count;i++){
        [URequests getImageWithURL:[[_data objectAtIndex:i] personaId] andPersona:[_data objectAtIndex:i]];
    }

    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.screenName = @"Favourites Screen - iOS";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    //NSDictionary *item = (NSDictionary *)[self.content objectAtIndex:indexPath.row];
    NSString* name = [[[_favs objectAtIndex:indexPath.row] objectForKey:@"venue"] objectForKey:@"name"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"         %@", name];//[item objectForKey:@"mainTitleKey"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = FONT_BOLD_SMALL;
    
    CGRect fr = cell.textLabel.frame;
    fr.origin.y -=2;
    fr.origin.x +=80;
    cell.textLabel.frame = fr;
    cell.tag = indexPath.row;//[[[_favs objectAtIndex:indexPath.row] objectForKey:@"venueid"] intValue];
    
    [cell setBackgroundColor:UIColorFromRGB(UGOGRAY)];
    // Get the image from the iconography
    NSString* imageIconName = [NSString stringWithFormat:@"%d.png",[[[[_favs objectAtIndex:indexPath.row] objectForKey:@"venue"] objectForKey:@"iconography"] intValue]];
    UIImageView* iconography = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageIconName]];
    
    int padding = 8;
    int height = cell.frame.size.height;
    int iconHeight = 20;
    [iconography setFrame:CGRectMake(padding/2,padding/2, iconHeight, iconHeight)];
    
    
    
    CGRect bgFrame = iconography.frame;
    bgFrame.size.height+=padding;
    bgFrame.size.width+=padding;
    bgFrame.origin.x = 15;
    bgFrame.origin.y = (height)/2 -((iconHeight+padding)/4)-1;
    
    UIView* iconBg = [[UIView alloc] initWithFrame:bgFrame];
    
    // Set the right color
    UIColor* color = UIColorFromRGB(UGO_TYPE2);
    switch ([[[[_favs objectAtIndex:indexPath.row] objectForKey:@"venue"] objectForKey:@"type"] intValue]) {
        case 0:
            color = UIColorFromRGB(UGO_TYPE1);
            break;
        case 1:
            color = UIColorFromRGB(UGO_TYPE2);
            break;
        case 2:
            color = UIColorFromRGB(UGO_TYPE3);
            break;
        case 3:
            color = UIColorFromRGB(UGO_TYPE4);
            break;
        default:
            break;
    }

    
    [iconBg setBackgroundColor:color];
    iconBg.layer.cornerRadius = (iconHeight+padding)/2;
    
    [iconBg addSubview:iconography];
 
    [cell addSubview:iconBg];
    
    
    UIImage *theImage = [UIImage imageNamed:@"favouritesCell@2x.png"];
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:theImage]];

    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Do whatever data deletion you need to do...
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [URequests deleteFavourite:[[[[[WSingleton sharedManager] favourites] objectAtIndex:indexPath.row] venue] dBID]];
        [_data removeObjectAtIndex:indexPath.row];
    
        
    }
    [tableView endUpdates];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[WSingleton sharedManager] setCurrentVenue:(int)[[tableView cellForRowAtIndexPath:indexPath] tag]];
    
    
    [self performSegueWithIdentifier:@"showFav" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setComingFromFav:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

@end
