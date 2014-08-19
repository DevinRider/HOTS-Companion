//
//  HeroSelectTableViewController.h
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/23/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DEVHero;

@protocol HeroSelectTableViewDelegate <NSObject>

- (void)heroSelected:(DEVHero *)selectedHero;

@end

@interface HeroSelectTableViewController : UITableViewController

@property (nonatomic, weak) id <HeroSelectTableViewDelegate> delegate;

@end
