//
//  DEVSingleHeroAbilityCell.h
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/28/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEVSingleHeroAbilityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cooldownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *abilityIconImage;

@end
