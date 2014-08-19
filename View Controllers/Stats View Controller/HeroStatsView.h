//
//  HeroStatsView.h
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/23/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DEVHero;

@interface HeroStatsView : UITableViewController

@property (nonatomic, weak) DEVHero *selectedHero;

@end
