//
//  URequests.m
//  U:GO
//
//  Created by Julien Saad on 1/5/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "URequests.h"
#import "Persona.h"
#import "WSingleton.h"

#import "AFHTTPRequestOperation.h"

@implementation URequests

+(void)getEventsWithSuccessFunction:(SEL)selector andSender:(id)sender{

	NSString *url = [NSString stringWithFormat:@"%@%@",WS_URL,@"webservice/get_active_personas.php"];
	
	NSURLSession *session = [NSURLSession sharedSession];
	[[session dataTaskWithURL:[NSURL URLWithString:url]
			completionHandler:^(NSData *data,
								NSURLResponse *response,
								NSError *error) {
				// handle response
				[URequests fetchedData:data];
                if(selector!=nil)
                    [sender performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
			}] resume];
}

#define kImageURL [NSString stringWithFormat:@"%@%@",WS_URL,@"img/"]
+(void)getImageWithURL:(NSString*)url andImageView:(UIImageView*)im{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@persona%@.jpg", kImageURL, url]]];
	

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

+(void)getImageWithURL:(NSString*)url andPersona:(Persona*)p{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@persona%@.jpg", kImageURL, url]]];
	
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
									  p.img = [[UIImage alloc] initWithData:data];

                                       
							   } else{
								   // Do nothing
							   }
                           }];
}

+(void)createUserWithUsername:(NSString*)name
                        andId:(int)userid
                     andFName:(NSString*)fname
                     andLName:(NSString*)lname
                    andGender:(NSString*)gender
                    andLocale:(NSString*)locale{
    // Create the user
}

+ (void)fetchedData:(NSData *)responseData {
    [[[WSingleton sharedManager] webContent] removeAllObjects];
    //parse out the json data
    NSError* error;
    NSArray* json = [NSJSONSerialization
						  JSONObjectWithData:responseData //1
						  
						  options:kNilOptions
						  error:&error];
	
    // NSLog(@"%@", [json description]);
	for(int i = 0; i<4 ; i++){
		NSDictionary* current = [json objectAtIndex:i];
		
        Persona *p = [[Persona alloc] init];
        [p setName:[current objectForKey:@"name"]];
        [p setPersonaId:[current objectForKey:@"id"]];
        
        [p setPersonaDescription:[current objectForKey:@"description"]];
        [p setPersonaDescriptionFr:[current objectForKey:@"description_fr"]];
        
        [p setPersonaNameFr:[current objectForKey:@"name_fr"]];
        [p setImgUrl:[current objectForKey:@"image"]];
		
		Venue *v = [[Venue alloc] init];
		if([[current objectForKey:@"venue"] class] != [NSNull class]){
			NSDictionary* venuInfo = [current objectForKey:@"venue"];
			[v setName:[venuInfo objectForKey:@"name"]];
			[v setLocation:[venuInfo objectForKey:@"location"]];
            [v setFbUrl:[NSString stringWithFormat:@"fb://profile/%@",[venuInfo objectForKey:@"facebook_url"]]];
			[v setDescriptionEn:[venuInfo objectForKey:@"description_en"]];
			[v setDescriptionFr:@"description_fr"];
			[v setType:[[venuInfo objectForKey:@"type"] intValue]];
            
            // Set the right color
            UIColor* color = UIColorFromRGB(UGO_TYPE2);
            switch ([v type]) {
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
            
            [v setColor:color];
            
            
			[v setVenueId:[NSString stringWithFormat:@"%d", i]];
            [v setDBID:[venuInfo objectForKey:@"id"]];
            [v setPhoneNumber:[venuInfo objectForKey:@"phone"]];
            [v setPrice:[[venuInfo objectForKey:@"price"] intValue]];
            [v setIcono:[[venuInfo objectForKey:@"iconography"] intValue]];
            [v setBestTime:[venuInfo objectForKey:@"best_time"]];
            
            

            
            NSMutableArray* imgArray = [[NSMutableArray alloc] init];
            NSArray* imgUrls = [venuInfo objectForKey:@"image"];
            for(NSDictionary* url in imgUrls){
                [imgArray addObject:[url objectForKey:@"url"]];
            }
            [v setImgUrls:imgArray];
			[p setVenue:v];
		}
		[[[WSingleton sharedManager]webContent] addObject:p];
	}
	
}


+(void)addFavourite:(NSString *)venueId{
    if(ISLOGGEDIN){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        
        NSDictionary *params = @{@"venue_id": venueId,
                                 @"user_id": [[[WSingleton sharedManager] defaults]objectForKey:@"userid"]};
        [manager POST:[NSString stringWithFormat:@"%@%@",WS_URL,@"webservice/add_favourite.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showImage:[UIImage imageNamed:@"heart"] status:@"Added to favourites!"];
            NSLog(@"SUCCESS: %@", [responseObject description]);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
         [SVProgressHUD showErrorWithStatus:@"Please sign in to use this feature!"];
    }
    
}

+(void)createUser:(NSDictionary *)params{
    
    if(!ISLOGGEDIN){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];

        [manager POST:[NSString stringWithFormat:@"%@%@",WS_URL,@"webservice/update_user.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showImage:[UIImage imageNamed:@"heart"] status:@"User created!"];
            NSLog(@"SUCCESS: %@", [responseObject description]);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

+(void)getFavourites:(SEL)selector :(id)sender{
    if(ISLOGGEDIN){
        
        [SVProgressHUD showWithStatus:@"Fetching your lovely favourites..."];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSDictionary *params = @{@"user_id": [[[WSingleton sharedManager] defaults] objectForKey:@"userid"]};
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager POST:[NSString stringWithFormat:@"%@%@",WS_URL,@"webservice/get_favourites.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"SUCCESS: %@", [responseObject description]);
            [SVProgressHUD dismiss];
            
            [[WSingleton sharedManager] setFavourites:[[NSMutableArray alloc] init]];
            
            for(int i = 0; i<[responseObject count] ; i++){
                NSDictionary* current = [responseObject objectAtIndex:i];
                NSLog(@"%@",current.description);
                Persona *p = [[Persona alloc] init];
                [p setName:[current objectForKey:@"name"]];
                [p setPersonaId:[current objectForKey:@"id"]];
                
                [p setPersonaDescription:[current objectForKey:@"description"]];
                [p setPersonaNameFr:[current objectForKey:@"name_fr"]];
                
                [p setPersonaDescriptionFr:[current objectForKey:@"description_fr"]];
                [p setImgUrl:[current objectForKey:@"image"]];
                
                Venue *v = [[Venue alloc] init];
                if([[current objectForKey:@"venue"] class] != [NSNull class]){
                    NSDictionary* venuInfo = [current objectForKey:@"venue"];
                    [v setName:[venuInfo objectForKey:@"name"]];
                    [v setLocation:[venuInfo objectForKey:@"location"]];
                    [v setFbUrl:[NSString stringWithFormat:@"fb://profile/%@",[venuInfo objectForKey:@"facebook_url"]]];
                    [v setDescriptionEn:[venuInfo objectForKey:@"description_en"]];
                    [v setDescriptionFr:@"description_fr"];
                    [v setType:[[venuInfo objectForKey:@"type"] intValue]];
                    [v setVenueId:[NSString stringWithFormat:@"%d", i]];
                    [v setDBID:[venuInfo objectForKey:@"id"]];
                    
                    [v setPhoneNumber:[venuInfo objectForKey:@"phone"]];
                    [v setPrice:[[venuInfo objectForKey:@"price"] intValue]];
                    [v setIcono:[[venuInfo objectForKey:@"iconography"] intValue]];
                    [v setBestTime:[venuInfo objectForKey:@"best_time"]];
                    

                    
                    
                    NSMutableArray* imgArray = [[NSMutableArray alloc] init];
                    NSArray* imgUrls = [venuInfo objectForKey:@"image"];
                    for(NSDictionary* url in imgUrls){
                        [imgArray addObject:[url objectForKey:@"url"]];
                    }
                    [v setImgUrls:imgArray];
                    [p setVenue:v];
                }
                [[[WSingleton sharedManager]favourites] addObject:p];
            }
            

            [sender performSelectorOnMainThread:selector withObject:responseObject waitUntilDone:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [SVProgressHUD dismiss];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"Please sign in to use this feature!"];
    }
}


+(void)deleteFavourite:(NSString *)venueId{
    if(ISLOGGEDIN){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        
        NSDictionary *params = @{@"venue_id": venueId,
                                 @"user_id": [[[WSingleton sharedManager] defaults]objectForKey:@"userid"]};
        [manager POST:[NSString stringWithFormat:@"%@%@",WS_URL,@"webservice/delete_favourite.php"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"SUCCESS: %@", [responseObject description]);
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"Please sign in to use this feature!"];
    }
    
}


@end
