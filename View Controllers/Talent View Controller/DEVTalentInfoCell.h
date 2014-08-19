//
//  DEVTalentInfoCell.h
//  HeroesAppRoundTwo
//
//  Created by Devin on 8/13/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEVTalentInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *cooldownLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
