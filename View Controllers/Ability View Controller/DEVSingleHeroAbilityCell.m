//
//  DEVSingleHeroAbilityCell.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/28/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVSingleHeroAbilityCell.h"

@implementation DEVSingleHeroAbilityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self.descriptionLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
