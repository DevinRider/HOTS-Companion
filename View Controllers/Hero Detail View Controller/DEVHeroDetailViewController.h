//
//  DEVHeroDetailViewController.h
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/23/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroSelectTableViewController.h"

@interface DEVHeroDetailViewController : UITableViewController<HeroSelectTableViewDelegate>

@property (nonatomic, strong) DEVHero *selectedHero;

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *roleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *heroImage;
@property (strong, nonatomic) IBOutlet UILabel *loreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *universeImage;

@end
