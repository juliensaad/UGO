//
//  USplashViewController.h
//  U:GO
//
//  Created by Julien Saad on 1/27/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UKingViewController.h"
#import "UButton.h"
#import "UPageContentViewController.h"

@interface USplashViewController : UKingViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *gLetter;
@property (weak, nonatomic) IBOutlet UIImageView *oLetter;
@property (weak, nonatomic) IBOutlet UIImageView *uLetter;
@property (weak, nonatomic) IBOutlet UIImageView *shadow;
@property (weak, nonatomic) IBOutlet UIImageView *splashText;
@property (weak, nonatomic) IBOutlet UButton *b1;
@property (weak, nonatomic) IBOutlet UButton *b2;
@property (weak, nonatomic) IBOutlet UButton *b3;

@property (weak, nonatomic) IBOutlet UIView *btnView;


@property (weak, nonatomic) IBOutlet UIView *sliderView;



- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


#define t1 @"Qu'est-ce que UGO?"
#define t2 @"(Re)découvrez votre ville"
#define t3 @"Les blogueurs"
#define t4 @"Naviguez à travers la ville"

#define l0 @"UGO n’est pas qu’une simple application téléphonique, c’est aussi une nouvelle façon de redécouvrir votre ville."
#define l01 @"Que vous ayez l’idée d’une soirée entre amis, d’un tête-à-tête au restaurant ou pour tout simplement profiter du meilleur torréfacteur en ville, UGO est là pour vous!"

#define l1 @"UGO ne profite d’aucune récompense de la part des restaurants, cafés, boutiques et entreprises représentés sur son interface. Adeptes de l’esprit montréalais, nous encourageons tout simplement les lieux aux concepts originaux qui ravitaillent en culture notre ville de cœur."
#define l12 @"Tout en souhaitant partager le plaisir de les découvrir, nous supportons les petites entreprises authentiques qui, sans recourir à la publicité, méritent plus de visibilité."

#define l2 @"Avec UGO vous explorerez Montréal sous un œil personnalisé. À travers les yeux de 20 persona soigneusement élaborées, chacune a ses préférences et agence ses recommandations en conséquences."
#define l22 @"Quatre personnalités seront mises en vedette à chaque semaine, qui chacun à sa façon, sait interpréter et trouver l’émoi partout à travers la ville. Suivez les mises à jour tous les lundis!"


#define l3 @"Destinée aux touristes comme aux résidents de l’Île, notre navigation propose un itinéraire d’un jour vous proposant des moments fantastiques pour (re)découvrir la ville par une journée montréalaise typique!"
#define l32 @""


@end
